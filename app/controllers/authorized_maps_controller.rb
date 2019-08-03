class AuthorizedMapsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_map, except: [:edit]
  before_action :set_authorized_users, only: [:index, :new, :create, :destroy]

  def index
    respond_to do |format|
      format.json
    end
  end

  def new
    @new_authorized = AuthorizedMap.new
  end
  
  def create
    if @authorized_user = User.find_by(authorized_params)
      @map.authorizing_user(@authorized_user)
      respond_to do |format|
        format.js { flash[:notice] = "ユーザー：#{@authorized_user.email} を追加しました。" } 
      end
    else
      respond_to do |format|
        format.js { flash[:warning] = "招待できないメールアドレスです" } 
      end
    end
  end

  def edit
  end

  def update
  end

  # 今のところテストデータを消す目的だけでこのアクションを利用中
  def destroy
    @authorized_users.each do |user|
      unless user.email == current_user.email
        AuthorizedMap.find_by(user_id: user.id).destroy
      end
    end
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

    def set_authorized_users
      @authorized_users = @map.authorized_users
    end

    def authorized_params
      params.require(:authorized_map).permit(:email)
    end
end