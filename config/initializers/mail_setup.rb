ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "thedesignpill.com",
  :user_name            => "j.mercedes@thedesignpill.com",
  :password             => "Alfaj0re2!",
  :authentication       => "plain",
  :enable_starttls_auto => true
}