class UsersController < ApplicationController
  before_filter :set_access_control_headers
  before_filter :authorize_application_token

  def authorize_application_token
    if request.headers['Application-Token'] != "59a3b1a51c80c8db71c9a881d8b23c6e2b41727c"
      render json: {error: 'UNAUTHORIZED'}, status: 401
    end
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end

  # POST /job_postings
  def create
    if user_params[:token] && @user = User.where(token: user_params[:token]).first
      render json: {user: @user}, status: 200
    else
      @user = User.new(user_params)

      if @user.save
        render json: {user: @user}, status: 201
      else
        render json: {error: @user.errors.full_messages}, status: 400
      end
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_posting
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.merge!(Yajl::Parser.parse(request.body.read, symbolize_keys: true))
      params.require(:user).permit(:name, :id, :token, :system_id)
    end
end
