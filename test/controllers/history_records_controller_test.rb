require 'test_helper'

class HistoryRecordsControllerTest < ActionController::TestCase
  setup do
    @history_record = history_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:history_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create history_record" do
    assert_difference('HistoryRecord.count') do
      post :create, history_record: { fields_to_store: @history_record.fields_to_store, historian_id: @history_record.historian_id, http_api_address: @history_record.http_api_address, public: @history_record.public, rate: @history_record.rate, title: @history_record.title }
    end

    assert_redirected_to history_record_path(assigns(:history_record))
  end

  test "should show history_record" do
    get :show, id: @history_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @history_record
    assert_response :success
  end

  test "should update history_record" do
    patch :update, id: @history_record, history_record: { fields_to_store: @history_record.fields_to_store, historian_id: @history_record.historian_id, http_api_address: @history_record.http_api_address, public: @history_record.public, rate: @history_record.rate, title: @history_record.title }
    assert_redirected_to history_record_path(assigns(:history_record))
  end

  test "should destroy history_record" do
    assert_difference('HistoryRecord.count', -1) do
      delete :destroy, id: @history_record
    end

    assert_redirected_to history_records_path
  end
end
