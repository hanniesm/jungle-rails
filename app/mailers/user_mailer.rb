class UserMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def order_email(email, order)
    @user = email
    @order = order
    @url = 'http://example.com/login'
    mail(to: @user, subject: 'Your Jungle Order #{order.id}')
  end

end
