# frozen_string_literal: true

json.following do
  json.project do
    json.id @project.id
    json.followers @followers
  end
  json.user do
    json.id @current_user.id
  end
end
