# frozen_string_literal: true

json.unfollowing do
  json.project do
    json.id @project.id
    json.followers @followers
  end
end
