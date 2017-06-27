# frozen_string_literal: true

json.comment do
  json.id @comment.id
  json.content @comment.content
  json.user do
    json.id @current_user.id
    json.href api_v1_user_url(@current_user)
    json.email @current_user.email
    json.first_name @current_user.firstname
    json.last_name @current_user.lastname
    json.birthdate @current_user.birthdate
    json.description @current_user.description
  end
  json.project do
    json.href api_v1_project_url(@comment.project)
    json.id @comment.project.id
    json.brief @comment.project.brief
    json.description @comment.project.description
    json.funding_duration @comment.project.funding_duration
    json.funding_goal @comment.project.funding_goal
  end
end
