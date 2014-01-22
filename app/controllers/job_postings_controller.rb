class JobPostingsController < ApplicationController
  before_action :set_job_posting, only: [:show, :edit, :update, :destroy]

  # GET /job_postings
  def index
    from  = params[:from]  || 0
    limit = params[:limit] || 10

    if params[:query]
      @job_postings = JobPosting.where('title like ?', "%#{params[:query]}%")
    else
      @job_postings = JobPosting
    end
    render json: @job_postings.offset(from).limit(limit)
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
      redirect_to @job_posting, notice: 'Job posting was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /job_postings/1
  def update
    if @job_posting.update(job_posting_params)
      redirect_to @job_posting, notice: 'Job posting was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /job_postings/1
  def destroy
    @job_posting.destroy
    redirect_to job_postings_url, notice: 'Job posting was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_posting
      @job_posting = JobPosting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_posting_params
      params.require(:job_posting).permit(:title, :employment_type, :location, :description, :compensation, :contact, :url)
    end
end
