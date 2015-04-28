class Notification < ApplicationMailer
  default from: 'prestamos@crediclub.com.do'
  
  def payment_notification(user)
    @user = user
    mail(to: user.email, subject: "Pago registrado")
    
  end
end
