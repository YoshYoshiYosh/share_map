class ContactMailer < ApplicationMailer
  default from: '"rails-heroku-sharemap" <service@example.com>'

  def contact_arrived_mail
    @sender  = params[:user]
    @opinion = params[:opinion]
    mail(to: "yoshikik@live.jp", subject: "#{@sender.email}様よりコンタクトメールが届きました。")
  end
  
end