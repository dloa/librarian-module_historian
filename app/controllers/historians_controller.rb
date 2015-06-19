class HistoriansController < ApplicationController
  before_action :set_historian, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  # GET /historians
  # GET /historians.json
  def index
    @historians = Historian.all
  end

  # GET /historians/1
  # GET /historians/1.json
  def show
  end

  # GET /historians/new
  def new
    @historian = Historian.new
  end

  # GET /historians/1/edit
  def edit
  end

  # POST /historians
  # POST /historians.json
  # input required name, address, btc_tip_address, bit_msg_address
  def create
    @historian = Historian.new(historian_params)
    @historian.send_to_florincoin
    if @historian.save
      redirect_to @historian, notice: 'Historian was successfully created.'
    else
      render :new
    end
  end


  # PATCH/PUT /historians/1
  # PATCH/PUT /historians/1.json
  def update
    if @historian.update(historian_params)
      redirect_to @historian, notice: 'Historian was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /historians/1
  # DELETE /historians/1.json
  def destroy
    @historian.destroy
    redirect_to historians_url, notice: 'Historian was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_historian
      @historian = Historian.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def historian_params
      params.require(:historian).permit(:name, :address, :btc_tip_address, :bit_msg_address, :txn_id)
    end
end
