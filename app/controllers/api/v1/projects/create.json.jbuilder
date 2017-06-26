
# frozen_string_literal: true

json.project do
  json.id @project.id
  json.href api_v1_project_url(@project)
  json.brief @project.brief
  json.description @project.description
  json.funding_duration @project.funding_duration
  json.funding_goal @project.funding_goal
  json.private @project.private
  json.user do
    json.href api_v1_user_url(@project.user)
    json.email @project.user.email
    json.first_name @project.user.first_name
    json.last_name @project.user.last_name
    json.birthdate @project.user.birthdate
    json.description @project.user.description
    json.wallet @project.user.wallet
  end
end
