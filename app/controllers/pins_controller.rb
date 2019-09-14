class PinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :set_map
  before_action :set_ip_address
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

    # IPアドレスの検証用コード
    remote_ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip

    respond_to do |format|
      if @pin.save
        format.html { redirect_to @map, notice: "Pin was successfully created.#{remote_ip}" }
      else
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

    def set_ip_address
      require 'uri'
      require 'net/http'
      require 'openssl'
      require 'json'
      
      url = URI("https://ip-geo-location.p.rapidapi.com/ip/60.150.226.216?format=json")
      
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-host"] = 'ip-geo-location.p.rapidapi.com'
      request["x-rapidapi-key"] = 'a70cd5897bmsh06091d0401bb855p108cd8jsn09868e0d771d'
      
      json = JSON.parse http.request(request).body
      
      { lat: json["location"]["latitude"], lon: json["location"]["longitude"] }

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params

      @lonlat = set_ip_address
      
      # params[:pin][:lonlat] = "POINT(#{params[:pin][:lonlat]})"
      params[:pin][:lonlat] = "POINT(#{@lonlat[:lat]} #{@lonlat[:lon]})"

      params.require(:pin).permit(:author_id, :title, :description, :lonlat, :image)
    end

    def can_edit?
      if current_user != @pin.author
        render 'errors/forbidden', status: 403
      end
    end

end
