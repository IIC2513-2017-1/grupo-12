# frozen_string_literal: true

json.donation do
  json.id @donation.id
  json.amount @donation.amount
  json.user do
    json.id @donation.user.id
    json.href api_v1_user_url(@donation.user)
    json.email @donation.user.email
    json.first_name @donation.user.firstname
    json.last_name @donation.user.lastname
    json.birthdate @donation.user.birthdate
    json.description @donation.user.description
  end
  json.project do
    json.href api_v1_project_url(@donation.project)
    json.id @donation.project.id
    json.brief @donation.project.brief
    json.description @donation.project.description
    json.funding_duration @donation.project.funding_duration
    json.funding_goal @donation.project.funding_goal
  end
end
