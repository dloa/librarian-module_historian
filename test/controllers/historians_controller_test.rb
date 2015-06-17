require 'test_helper'

class HistoriansControllerTest < ActionController::TestCase
  setup do
    @historian = historians(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:historians)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create historian" do
    assert_difference('Historian.count') do
      post :create, historian: { address: @historian.address, bit_msg_address: @historian.bit_msg_address, btc_tip_address: @historian.btc_tip_address, name: @historian.name }
    end

    assert_redirected_to historian_path(assigns(:historian))
  end

  test "should show historian" do
    get :show, id: @historian
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @historian
    assert_response :success
  end

  test "should update historian" do
    patch :update, id: @historian, historian: { address: @historian.address, bit_msg_address: @historian.bit_msg_address, btc_tip_address: @historian.btc_tip_address, name: @historian.name }
    assert_redirected_to historian_path(assigns(:historian))
  end

  test "should destroy historian" do
    assert_difference('Historian.count', -1) do
      delete :destroy, id: @historian
    end

    assert_redirected_to historians_path
  end
end
