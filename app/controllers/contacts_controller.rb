class ContactsController < ApplicationController

  # https://www.javadrive.jp/rails/controller/index6.html
  
  def create
    if user_signed_in?
      opinion = params[:contact]
      # flash[:success] = "#{opinion}!!"
      puts "#{opinion}"
      ContactMailer.with(user: current_user, opinion: opinion).contact_arrived_mail.deliver_now
      redirect_to root_url
    end
  end
end