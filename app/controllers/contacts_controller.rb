class ContactsController < ApplicationController
  before_action :authenticate_user!
  # https://www.javadrive.jp/rails/controller/index6.html
  
  def create
    opinion = params[:contact]
    ContactMailer.with(user: current_user, opinion: opinion).contact_arrived_mail.deliver_now
    redirect_to root_url # JavaScriptでPOSTしているため、この行は動作しない
  end
end