# frozen_string_literal: true

class PinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pin, only: %i[show edit update destroy]
  before_action :set_map
  before_action :can_edit?, only: %i[edit update destroy]
  before_action :get_previous_url, only: :index
  protect_from_forgery

  def index
    @pins = Pin.where(map: @map).map do |pin|
      pin.as_json(except: :lonlat).merge(
        lonlat: pin.custom_lonlat,
        image: pin.custom_image,
        author: pin.author.email,
        avatar: pin.custom_avatar
      ) 
    end
    render json: @pins
  end
  
  def show; end

  def new
    @pin = Pin.new(map: @map)
  end

  def edit; end

  def create
    @pin = Pin.new(pin_params)
    @pin.author = current_user
    @pin.map = @map

    if @pin.save
      flash[:notice] = 'ピンの作成が完了しました！'
      render json: {}, status: 201
    else
      render json: {}, status: 400
    end
  end

  def update
    respond_to do |format|
      if @pin.update(pin_params)
        format.html { redirect_to pin_url(@map, @pin), notice: 'Pin was successfully updated.' }
        format.json { render :show, status: :ok, location: @pin }
      else
        format.html { render :edit }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pin.destroy
    respond_to do |format|
      format.html { redirect_to pins_url(@map), notice: 'Pin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_pin
    @pin = Pin.find(params[:id])
  end

  def set_map
    @map = Map.find(params[:map_id])
  end

  def pin_params
    params[:pin][:lonlat] = "POINT(#{params[:pin][:lonlat]})"
    params.require(:pin).permit(:author_id, :title, :description, :lonlat, :image)
  end

  def can_edit?
    render 'errors/forbidden', status: 403 if current_user != @pin.author
  end

  def get_previous_url
    unless request.url.include?('pins.json')
      @previous_url = session[:previous_action]
      session.delete(:previous_action)
    end
  end
end
