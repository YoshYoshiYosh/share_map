# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :authenticate_user!

  def create
    opinion = params[:contact]
    ContactMailer.with(user: current_user, opinion: opinion).contact_arrived_mail.deliver_now
    render json: {}, status: 201
  end
end
