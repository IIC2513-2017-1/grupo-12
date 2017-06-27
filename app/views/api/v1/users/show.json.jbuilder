# frozen_string_literal: true

json.user do
  json.id @user.id
  json.email @user.email
  json.first_name @user.firstname
  json.last_name @user.lastname
  json.birthdate @user.birthdate
  json.description @user.description
  json.created do
    json.array! @user.projects do |project|
      json.id project.id
      json.href api_v1_project_url(project)
      json.brief project.brief
      json.description project.description
      json.funding_duration project.funding_duration
      json.funding_goal project.funding_goal
    end
  end
  json.supported do
    json.array! @supported_projects do |project|
      json.id project.id
      json.href api_v1_project_url(project)
      json.brief project.brief
      json.description project.description
      json.funding_duration project.funding_duration
      json.funding_goal project.funding_goal
    end
  end
end
