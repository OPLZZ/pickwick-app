class JobPostingsController < ApplicationController
  before_action :set_job_posting, only: [:show, :edit, :update, :destroy]
  before_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end

  # GET /job_postings
  def index

  end

  # GET /job_postings/1
  def show
    render json: @job_posting
  end

  # GET /job_postings/new
  def new
    @job_posting = JobPosting.new
    render json: @job_posting
  end

  # GET /job_postings/1/edit
  def edit
  end

  # POST /job_postings
  def create
    @job_posting = JobPosting.new(job_posting_params)

    if @job_posting.save
      render json: {user: @job_posting}, status: 201
    else
      render json: {error: @job_posting.errors.full_messages}, status: 400
    end
  end

  # PATCH/PUT /job_postings/1
  def update
    if @job_posting.update(job_posting_params)
      render json: {user: @user}, status: 200
    else
      render json: {error: @user.errors.full_messages}, status: 400
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
      @job_posting = JobPosting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_posting_params
      params.merge!(Yajl::Parser.parse(request.body.read, symbolize_keys: true))
      params.require(:job_posting).permit(:id, :user_id, :title, :description, :employment_type,
        location: [:street, :city, :zip],
        compensation: [:value, :min_value, :max_value, :type, :currency],
        contact: [:name, :phone, :email],
        employer: [:name, :company]
      )
    end
end
