class JobPostingsController < ApplicationController
  before_action :set_user, except: [:admin_index, :admin_valid, :admin_invalid]
  before_action :set_job_posting, only: [:show, :edit, :update, :destroy]
  before_filter :set_access_control_headers
  before_filter :authorize_application_token, except: [:admin_index, :admin_valid, :admin_invalid]

  before_filter :authenticate_admin, only: [:admin_index, :admin_valid, :admin_invalid]

  def authenticate_admin
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['PICKWICK_ADMIN_USERNAME'] && password == ENV['PICKWICK_ADMIN_PASSWORD']
    end
  end

  def admin_index
    if params[:filter] == "all"
      @filter = params[:filter]
      @job_postings = JobPosting.order('created_at desc').includes(:user)
    else
      @filter = 'not_checked'
      @job_postings = JobPosting.where(checked: 'not_checked').order(:created_at).includes(:user)
    end
    render :admin_index, layout: 'admin'
  end

  def admin_valid
    @job_posting = JobPosting.find(params[:id])
    @job_posting.set_valid
    @job_postings = JobPosting.where(checked: 'not_checked').order(:created_at).includes(:user)
    redirect_to :admin_index
  end

  def admin_invalid
    @job_posting = JobPosting.find(params[:id])
    @job_posting.set_invalid
    @job_postings = JobPosting.where(checked: 'not_checked').order(:created_at).includes(:user)
    redirect_to :admin_index
  end


  def authorize_application_token
    if request.headers['Application-Token'] != "59a3b1a51c80c8db71c9a881d8b23c6e2b41727c"
      render json: {error: 'UNAUTHORIZED'}, status: 401
    end
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end

  # GET /job_postings
  def index
    render json: {job_postings: @user.job_postings.order('lower(title)'), total: @user.job_postings.count}
  end

  # POST /job_postings
  def create
    @job_posting = @user.job_postings.build(job_posting_params)

    if @job_posting.save
      render json: {job_posting: @job_posting}, status: 201
    else
      render json: {error: @job_posting.errors.full_messages}, status: 400
    end
  end

  # PATCH/PUT /job_postings/1
  def update
    if @job_posting.update(job_posting_params.merge(checked: 'not_checked'))
      render json: {job_posting: @job_posting}, status: 200
    else
      render json: {error: @job_posting.errors.full_messages}, status: 400
    end
  end

  # DELETE /job_postings/1
  def destroy
    @job_posting.destroy
    render json: {}, status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_posting
      @job_posting = @user.job_postings.where(id: params[:id]).first
    end

    def set_user
      @user = User.find(params[:user_id])
      if @user.token != request.headers['User-Token']
        render json: {error: 'UNAUTHORIZED'}, status: 401
      end
    end

    # Only allow a trusted parameter "white list" through.
    def job_posting_params
      params.merge!(Yajl::Parser.parse(request.body.read, symbolize_keys: true))
      params.require(:job_posting).permit(:id, :user_id, :title, :description, :employment_type, :start_date,
        location: [:street, :city, :zip],
        compensation: [:value, :min_value, :max_value, :type, :currency, :compensation_type],
        contact: [:name, :phone, :email],
        employer: [:name, :type]
      )
    end
end
