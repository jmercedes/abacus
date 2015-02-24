require 'rails_helper'

describe "user registration" do
  it "allows new users to register with an email address, password and name" do
  visit "/users/sign_up"
  
  fill_in "Nombre",                     :with => "John"
  fill_in "Correo Electrónico",         :with => "johndoe@example.com"
  fill_in "Contraseña",                 :with => "secret"
  fill_in "Confirm password",           :with => "secret"
  
  click_button "Regístrate"
  expect(page). to have_content "Welcome! You have signed up successfully"
  end
end