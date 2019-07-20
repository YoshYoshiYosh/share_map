class AuthorizedMapsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_map, only: [:index, :new, :create, :update]

  def index
    @authorized_maps = AuthorizedMap.where(map: @map)
  end

  def new
    @authorized = AuthorizedMap.new
  end
  
  def create
    @new_authorized = AuthorizedMap.new(authorized_params)
    @new_authorized.map = @map

    if @new_authorized.save
      flash[:notice] = "ユーザー：#{@new_authorized.user.email} を追加しました。"
      redirect_to map_url(@map)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  private
    def author?
      if current_user != @map.author
        flash[:notice] = "ユーザーを招待する権限がありません。"
        redirect_to map_url(@map)
      end
    end

    def set_map
      @map = Map.find(params[:map_id])
      author?
    end

    def authorized_params
      allowed_user = User.find_by(email: params[:authorized][:user_id])
      params[:authorized][:user_id] = allowed_user.id
      params.require(:authorized).permit(:user_id)
    end
end