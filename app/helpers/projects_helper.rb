module ProjectsHelper
  def following_project_button(project)
    return unless current_user
    following_relation = current_user.active_project_relationships.find_by(saved: project)
    if following_relation
      link_to 'Unfollow', forget_project_path(id: project, format: :json), method: 'delete', remote: true
    else
      link_to 'Follow', save_project_path(id: project, format: :json), method: 'post', remote: true
    end
  end
end
