
# frozen_string_literal: true

json.project do
  json.id @project.id
  json.href api_v1_project_url(@project)
  json.brief @project.brief
  json.description @project.description
  json.funding_duration @project.funding_duration
  json.funding_goal @project.funding_goal
  json.user do
    json.id @project.user.id
    json.href api_v1_user_url(@project.user)
    json.email @project.user.email
    json.first_name @project.user.firstname
    json.last_name @project.user.lastname
    json.birthdate @project.user.birthdate
    json.description @project.user.description
  end
end
