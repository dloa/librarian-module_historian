class HistoriansController < ApplicationController
  before_action :set_historian, only: [:show, :edit, :update, :destroy]

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
  def create
    @historian = Historian.new(historian_params)

    respond_to do |format|
      if @historian.save
        format.html { redirect_to @historian, notice: 'Historian was successfully created.' }
        format.json { render :show, status: :created, location: @historian }
      else
        format.html { render :new }
        format.json { render json: @historian.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /historians/1
  # PATCH/PUT /historians/1.json
  def update
    respond_to do |format|
      if @historian.update(historian_params)
        format.html { redirect_to @historian, notice: 'Historian was successfully updated.' }
        format.json { render :show, status: :ok, location: @historian }
      else
        format.html { render :edit }
        format.json { render json: @historian.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /historians/1
  # DELETE /historians/1.json
  def destroy
    @historian.destroy
    respond_to do |format|
      format.html { redirect_to historians_url, notice: 'Historian was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_historian
      @historian = Historian.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def historian_params
      params.require(:historian).permit(:name, :address, :btc_tip_address, :bit_msg_address)
    end
end
