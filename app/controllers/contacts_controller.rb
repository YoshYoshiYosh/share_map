class ContactsController < ApplicationController

  # https://www.javadrive.jp/rails/controller/index6.html
  
  def create
    byebug
    opinion = params[:contact]
    redirect_to root_url
  end
  
end