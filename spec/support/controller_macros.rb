# frozen_string_literal: true

module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]

      # user = User.create(
      #   email: 'test@example.com',
      #   password: 'Password',
      #   password_confirmation: 'Password'
      # )
      user.confirm # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end
