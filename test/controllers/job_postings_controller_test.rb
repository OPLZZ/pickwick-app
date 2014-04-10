require 'test_helper'

class JobPostingsControllerTest < ActionController::TestCase
  setup do
    @job_posting = job_postings(:one)
    @user = users(:one)

    @job_posting_data = {
      title: 'testing title'
    }
    @job_posting_data_update = {
      title: 'updated title'
    }
  end

  test "should get index" do
    get :index, user_id: @user.id
    assert_response :success
    assert_not_nil assigns(:job_postings)
  end

  test "should create job_posting" do
    assert_difference('JobPosting.count') do
      data = {job_posting: @job_posting_data }
      post :create,  data.to_json, { user_id: @user.id,format: 'json', content_type: 'json'}
    end

    assert_response :success
  end

  test "should show job_posting" do
    get :show, user_id: @user.id, id: @job_posting
    assert_response :success
  end

  test "should update job_posting" do
    data = {job_posting: @job_posting_data_update }
    patch :update, data.to_json, {user_id: @user.id, id: @job_posting, "Content-Type" => "application/json"}
    assert_response :success
  end

  test "should destroy job_posting" do
    assert_difference('JobPosting.count', -1) do
      delete :destroy, user_id: @user.id, id: @job_posting
    end

    assert_response :success
  end
end
