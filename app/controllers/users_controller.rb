class UsersController < ApplicationController
  before_filter :set_access_control_headers
  before_filter :authorize_application_token

  def authorize_application_token
    if request.headers['Application-Token'] != "59a3b1a51c80c8db71c9a881d8b23c6e2b41727c"
      render json: {error: 'UNAUTHORIZED'}, status: 401 and return
    end
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end

  # POST /job_postings
  def create

    create_params = user_params
    begin
      fb_user = FbGraph::User.me(user_params[:token]).fetch
      create_params[:system_id] = fb_user.identifier
      create_params[:name] = fb_user.name
    rescue Exception => e
      render json: {error: 'INVALID LOGIN', message: e.message}, status: 400 and return
    end

    if user_params[:token] && @user = User.where(system_id: create_params[:system_id]).first
      #update token if needed
      @user.token = user_params[:token] if @user.token != user_params[:token]
      @user.save
      render json: {user: @user}, status: 200 and return
    else
      @user = User.new(create_params)

      if @user.save
        render json: {user: @user}, status: 201 and return
      else
        render json: {error: @user.errors.full_messages}, status: 400 and return
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
