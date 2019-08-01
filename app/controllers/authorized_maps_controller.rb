class AuthorizedMapsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_map, only: [:index, :new, :create, :update]

  def index
    @authorized_users = @map.authorized_users
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @new_authorized = AuthorizedMap.new
    @authorized_users = @map.authorized_users
  end
  
  def create
    @authorized_users = @map.authorized_users
    if @authorized_user = User.find_by(authorized_params)
      @map.authorizing_user(@authorized_user)
      flash[:notice] = "ユーザー：#{@authorized_user.email} を追加しました。"
      respond_to do |format|
        # format.html { redirect_to new_map_authorize_url(@map) }

        # jQueryを導入した上でcreate.js.erbに処理内容を書く
        format.js { flash[:notice] = "ユーザー：#{@authorized_user.email} を追加しました。" } 
      end
    else
      flash[:notice] = "招待できないメールアドレスです"
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
      # バックアップ
      # allowed_user = User.find_by(email: params[:authorized_map][:user_id])
      # params[:authorized_map][:user_id] = allowed_user.id unless allowed_user == nil
      # params.require(:authorized_map).permit(:user_id)

      # チャレンジ
      params.require(:authorized_map).permit(:email)
    end
end