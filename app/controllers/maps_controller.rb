class MapsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_map, only: [:show, :edit, :update, :destroy, :admin]
  before_action :set_pins, only: [:show]
  before_action :can_edit?, only: [:show, :edit, :update, :destroy]
  before_action :author?, only: [:admin]

  before_action :is_show_or_admin?, only: [:show, :admin]

  # GET /maps
  # GET /maps.json
  def index
    # 削除予定
    @maps = Map.all
  end
  
  # GET /maps/1
  # GET /maps/1.json
  def show
    @new_authorized = AuthorizedMap.new(map: @map)
    @pin = Pin.new(map: @map)
  end

  # GET /maps/mymap
  # GET /maps/mymap.json
  def mymap
    @maps = Map.all.where(author: current_user)
    @can_view_map = current_user.can_edit_maps

    respond_to do |format|
      format.html
      format.json { render :json => @maps }
    end
  end

  def admin
  end

  # GET /maps/new
  def new
    @map = Map.new
  end

  # GET /maps/1/edit
  def edit
  end

  # POST /maps
  # POST /maps.json
  def create
    @map = Map.new(map_params)
    @map.author = current_user

    respond_to do |format|
      if @map.save
        format.html { redirect_to @map, notice: 'Map was successfully created.' }
        format.json { render :show, status: :created, location: @map }
      else
        format.html { render :new }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maps/1
  # PATCH/PUT /maps/1.json
  def update
    respond_to do |format|
      if @map.update(map_params)
        format.html { redirect_to @map, notice: 'Map was successfully updated.' }
        format.json { render :show, status: :ok, location: @map }
      else
        format.html { render :edit }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maps/1
  # DELETE /maps/1.json
  def destroy
    @map.destroy
    respond_to do |format|
      format.html { redirect_to maps_url, notice: 'Map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_map
      @map = Map.find(params[:id])
    end

    def set_pins
      @pins = @map.pins
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def map_params
      params.require(:map).permit(:title, :description)
    end

    def can_edit?
      if current_user != @map.author && @map.authorized_users.exclude?(current_user)
        render 'errors/forbidden', status: 403
      end
    end

    def author?
      if current_user != @map.author
        render 'errors/forbidden', status: 403
      end
    end

    def is_show_or_admin?
      session[:previous_action] = request.url.include?("admin") ? "admin" : "show"
    end

end
