module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, size, **kwargs)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    default_url = 'https://grupo-12.herokuapp.com/default_avatar.png'
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI.escape(default_url)}"
    if kwargs[:class]
      kwargs[:class] += ' gravatar img-circle'
      return image_tag(gravatar_url, alt: user.fullname, class: kwargs[:class])
    else
      image_tag(gravatar_url, alt: user.fullname, class: 'gravatar img-circle')
    end
  end
end
