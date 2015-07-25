require 'test_helper'

class Api::V1::Users::DevicesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'create with all attributes' do
    assert_difference('Device.count', 1) do
      assert_difference('User.find(1).devices.count', 1) do
        @request.headers['HTTP_AUTHORIZATION'] = 'Token 123456789012345'
        post :create, user_id: 1, device: { push_id: '24680' }

        body = JSON.parse(response.body)
        assert_not_nil body['push_id']
        assert_equal({ 'push_id' => body['push_id'] }, body)

        assert_response 200
      end
    end
  end

  test 'create with existing attributes' do
    assert_difference('Device.count', 0) do
      @request.headers['HTTP_AUTHORIZATION'] = 'Token 123456789012345'
      post :create, user_id: 1, device: {push_id: '123456' }

      body = JSON.parse(response.body)
      assert_not_nil body['push_id']
      assert_equal({ 'push_id' => body['push_id'] }, body)

      assert_response 200
    end
  end

  test 'update user device token' do
    assert_difference('Device.count', 0) do
      assert_difference('User.find(1).devices.count', 1) do
        @request.headers['HTTP_AUTHORIZATION'] = 'Token 123456789012345'
        post :create, user_id: 1, device: { push_id: '246802' }

        body = JSON.parse(response.body)
        assert_not_nil body['push_id']
        assert_equal({ 'push_id' => body['push_id'] }, body)

        assert_response 200
      end
    end
  end

  test 'create with with wrong token' do
    @request.headers['HTTP_AUTHORIZATION'] = 'Token wrong_token'
    post :create, {user_id: 1}, {device: {push_id: '24680' }}
    assert_response 401
  end
end
