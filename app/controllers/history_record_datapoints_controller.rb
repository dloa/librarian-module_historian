class HistoryRecordDatapointsController < ApplicationController
  before_action :set_history_record_datapoint, only: [:show, :edit, :update, :destroy]

  # GET /history_record_datapoints
  # GET /history_record_datapoints.json
  def index
    @history_record_datapoints = HistoryRecordDatapoint.all
  end

  # GET /history_record_datapoints/1
  # GET /history_record_datapoints/1.json
  def show
  end

  # GET /history_record_datapoints/new
  def new
    @history_record_datapoint = HistoryRecordDatapoint.new
  end

  # GET /history_record_datapoints/1/edit
  def edit
  end

  # POST /history_record_datapoints
  # POST /history_record_datapoints.json
  def create
    @history_record_datapoint = HistoryRecordDatapoint.new(history_record_datapoint_params)

    respond_to do |format|
      if @history_record_datapoint.save
        format.html { redirect_to @history_record_datapoint, notice: 'History record datapoint was successfully created.' }
        format.json { render :show, status: :created, location: @history_record_datapoint }
      else
        format.html { render :new }
        format.json { render json: @history_record_datapoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /history_record_datapoints/1
  # PATCH/PUT /history_record_datapoints/1.json
  def update
    respond_to do |format|
      if @history_record_datapoint.update(history_record_datapoint_params)
        format.html { redirect_to @history_record_datapoint, notice: 'History record datapoint was successfully updated.' }
        format.json { render :show, status: :ok, location: @history_record_datapoint }
      else
        format.html { render :edit }
        format.json { render json: @history_record_datapoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /history_record_datapoints/1
  # DELETE /history_record_datapoints/1.json
  def destroy
    @history_record_datapoint.destroy
    respond_to do |format|
      format.html { redirect_to history_record_datapoints_url, notice: 'History record datapoint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history_record_datapoint
      @history_record_datapoint = HistoryRecordDatapoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_record_datapoint_params
      params.require(:history_record_datapoint).permit(:history_record_id, :dp_field, :dp_value)
    end
end
