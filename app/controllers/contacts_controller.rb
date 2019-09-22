class ContactsController < ApplicationController
  before_action :authenticate_user!
  
  def create
      opinion = params[:contact]
      ContactMailer.with(user: current_user, opinion: opinion).contact_arrived_mail.deliver_now
      redirect_to root_url # JavaScriptにてレンダリングするため、この行は何もしない
  end
end