class ContactMailer < ApplicationMailer
  default from: 'from@example.com'

  def contact_arrived_mail
    @sender  = params[:user]
    @opinion = params[:opinion]
    mail(to: "yoshikik@live.jp", subject: "#{@sender}様よりコンタクトメールが届きました。")
  end
  
end