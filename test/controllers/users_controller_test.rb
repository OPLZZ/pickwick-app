require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should create user" do
    data = {user: { name: @user.name, token: 'supertoken'}}
    assert_difference('User.count') do
      post :create,  data.to_json, {format: 'json', content_type: 'json'}
    end

    assert_response :success
    out = Yajl::Parser.parse(response.body, symbolize_keys: true)
    getted_id = out[:user][:id]
    assert_not_nil getted_id, "should return user id"

    #create again - should return same ID
    post :create,  data.to_json, {format: 'json', content_type: 'json'}

    assert_response :success
    out = Yajl::Parser.parse(response.body, symbolize_keys: true)
    assert_equal getted_id, out[:user][:id], "should return user with same id"
  end

end
