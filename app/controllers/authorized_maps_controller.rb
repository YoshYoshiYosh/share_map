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
    if (@authorized_user = User.find_by(authorized_params)) && (@authorized_user != current_user)
      begin
        @map.authorizing_user(@authorized_user)
        flash[:success] = "ユーザー：#{@authorized_user.email} を追加しました。"
      rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid => e
        flash.delete(:success)
        flash[:danger] = "（既存ユーザーを招待した場合のメッセージ）招待できないメールアドレスです"
      end
    elsif @authorized_user == current_user
      flash[:danger] = "自分を招待することはできません"
    else
      flash[:danger] = "（存在しないユーザーを招待した場合のメッセージ）招待できないメールアドレスです"
    end

    redirect_to new_map_authorized_map_path(@map)
  end

  def edit; end

  def update; end

  # 今のところテストデータを消す目的だけでこのアクションを利用中
  def destroy
    @authorized_users.each do |user|
      AuthorizedMap.find_by(user_id: user.id).destroy unless user.email == current_user.email
    end
  end

  private

  # 招待する画面へ遷移するボタン自体を削除する可能性あり。そうなった場合はこのメソッドは削除する。
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
