module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, size, **kwargs)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    default_url = 'http://oi66.tinypic.com/2z8rxae.jpg'
    default_url = 'http://oi68.tinypic.com/2lw61ko.jpg' if size == 40
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI.escape(default_url)}"
    if kwargs[:class]
      kwargs[:class] += ' gravatar img-circle'
      return image_tag(gravatar_url, alt: user.fullname, class: kwargs[:class])
    else
      image_tag(gravatar_url, alt: user.fullname, class: 'gravatar img-circle')
    end
  end

  def following_button(user)
    return unless current_user
    return if user == current_user
    following_relation = current_user.active_relationships.find_by(followed_id: user.id)
    if following_relation
      link_to('Unfollow', relationship_path(id: following_relation, format: :json), method: 'delete', remote: true)
    else
      link_to('Follow', relationships_path(id: user, format: :json), method: 'post', remote: true)
    end
  end
end
