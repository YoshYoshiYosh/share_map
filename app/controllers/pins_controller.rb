class PinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :set_map
  before_action :can_edit?, only: [:edit, :update, :destroy] # :showを制限するか悩み中
  protect_from_forgery

  # GET /pins
  # GET /pins.json
  def index
    @pins = Pin.all.where(map: @map)

    respond_to do |format|
      format.html
      format.json
    end
  end

  # GET /pins/1
  # GET /pins/1.json
  def show
  end

  # GET /pins/new
  # Mapモデルと紐づけるのを忘れないように実装する
  def new
    @pin = Pin.new
  end

  # GET /pins/1/edit
  def edit
  end

  # POST /pins
  # POST /pins.json
  def create
    @pin = Pin.new(pin_params)
    @pin.author = current_user
    @pin.map = @map

    respond_to do |format|
      if @pin.save
        # format.html { redirect_to map_pin_url(@map, @pin), notice: 'Pin was successfully created.' }
        # format.json { render :show, status: :created, location: [@map, @pin] }
        # format.json { render :index }
        format.js { flash[:success] = "ピンが無事に作成された。" }
      else
        # format.html { render :new }
        # format.json { render json: @pin.errors, status: :unprocessable_entity }
        format.js { flash[:danger] = "入力が完了していない項目があります。" }
      end
    end
  end

  # PATCH/PUT /pins/1
  # PATCH/PUT /pins/1.json
  def update
    respond_to do |format|
      if @pin.update(pin_params)
        format.html { redirect_to map_pin_url(@map, @pin), notice: 'Pin was successfully updated.' }
        format.json { render :show, status: :ok, location: @pin }
      else
        format.html { render :edit }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.json
  def destroy
    @pin.destroy
    respond_to do |format|
      format.html { redirect_to map_pins_url(@map), notice: 'Pin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def set_map
      @map = Map.find(params[:map_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params[:pin][:lonlat] = "POINT(#{params[:pin][:lonlat]})"
      params.require(:pin).permit(:author_id, :title, :description, :lonlat)
    end

    def can_edit?
      if current_user != @pin.author
        render 'errors/forbidden', status: 403
      end
    end

end
