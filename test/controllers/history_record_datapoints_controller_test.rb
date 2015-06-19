require 'test_helper'

class HistoryRecordDatapointsControllerTest < ActionController::TestCase
  setup do
    @history_record_datapoint = history_record_datapoints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:history_record_datapoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create history_record_datapoint" do
    assert_difference('HistoryRecordDatapoint.count') do
      post :create, history_record_datapoint: { dp_field: @history_record_datapoint.dp_field, dp_value: @history_record_datapoint.dp_value, history_record_id: @history_record_datapoint.history_record_id }
    end

    assert_redirected_to history_record_datapoint_path(assigns(:history_record_datapoint))
  end

  test "should show history_record_datapoint" do
    get :show, id: @history_record_datapoint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @history_record_datapoint
    assert_response :success
  end

  test "should update history_record_datapoint" do
    patch :update, id: @history_record_datapoint, history_record_datapoint: { dp_field: @history_record_datapoint.dp_field, dp_value: @history_record_datapoint.dp_value, history_record_id: @history_record_datapoint.history_record_id }
    assert_redirected_to history_record_datapoint_path(assigns(:history_record_datapoint))
  end

  test "should destroy history_record_datapoint" do
    assert_difference('HistoryRecordDatapoint.count', -1) do
      delete :destroy, id: @history_record_datapoint
    end

    assert_redirected_to history_record_datapoints_path
  end
end
