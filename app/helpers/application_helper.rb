module ApplicationHelper

  def display_user(user)
    image_tag(user.image_url, size: "30", alt: user.name) +" "+ link_to(user.name, user_path(user.nickname))
  end

end
