class ContactsController < ApplicationController
  before_action :authenticate_user_for_contact
  # https://www.javadrive.jp/rails/controller/index6.html
  
  def create
    opinion = params[:contact]
    ContactMailer.with(user: current_user, opinion: opinion).contact_arrived_mail.deliver_now
    render 'home/index'
  end

  def authenticate_user_for_contact
    render 'home/index', status: 403 unless user_signed_in?
  end
end