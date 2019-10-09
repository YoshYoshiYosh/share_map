# frozen_string_literal: true

class ContactsController < ApplicationController
  # before_action :authenticate_user_for_contact
  before_action :authenticate_user!
  # https://www.javadrive.jp/rails/controller/index6.html

  def create
    opinion = params[:contact]
    ContactMailer.with(user: current_user, opinion: opinion).contact_arrived_mail.deliver_now
    render json: {}, status: 201
  end
end
