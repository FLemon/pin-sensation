module ApplicationHelper
  def mapped_omniauth(provider)
    map = { :google_oauth2 => "Google" }
    map.fetch(provider)
  end

  def user_firstname
    current_user.email.match(/^(.*)\..*@/)[1]
  end
end
