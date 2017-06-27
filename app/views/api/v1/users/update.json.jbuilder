# frozen_string_literal: true

json.user do
  json.id @user.id
  json.email @user.email
  json.first_name @user.firstname
  json.last_name @user.lastname
  json.birthdate @user.birthdate
  json.description @user.description
  json.wallet @user.wallet
end
