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
    @new_authorized = AuthorizedMap.new(map: @map)
  end
  
  def create
    if @authorized_user = User.find_by(authorized_params)
      begin
        @map.authorizing_user(@authorized_user)
        # authorizing_userメソッドを呼んでいるモデル側のファイルでbegin~endまでかく。validateでもかく。
        
        flash[:success] = "ユーザー：#{@authorized_user.email} を追加しました。"
      rescue ActiveRecord::RecordNotUnique => e
        puts "----------------------------------------------------------------------"
        puts "#{e.class}"
        puts "#{e.message}"
        puts "----------------------------------------------------------------------"
        
        flash.delete(:success)
        flash[:danger] = "（既存ユーザーを招待した場合のメッセージ）招待できないメールアドレスです"
      end
    else
      flash[:danger] = "（存在しないユーザーを招待した場合のメッセージ）招待できないメールアドレスです"
    end

    redirect_to new_map_authorized_map_path(@map)

  end


  # バックアップ
  # def create
  #   if @authorized_user = User.find_by(authorized_params)
  #     if @map.authorizing_user(@authorized_user)
  #       flash[:success] = "ユーザー：#{@authorized_user.email} を追加しました。"
  #     else
  #       flash[:danger] = "（既存ユーザーを招待した場合のメッセージ）招待できないメールアドレスです"
  #       # これが呼ばれる前にサーバーエラー500が返る
  #     end
  #   else
  #     flash[:danger] = "招待できないメールアドレスです"
  #     # ちゃんと動く
  #   end

  #   puts '呼ばれました。'
  #   redirect_to new_map_authorized_map_path(@map)

  # end
  
  
  
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