class Notifier < ApplicationMailer
  default from: "no-reply@jungle.com"

  def sample_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: "Your order... id #{@order.id} ")
  end
end

