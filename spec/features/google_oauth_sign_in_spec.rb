require 'rails_helper'
require 'omniauth_helpers'

feature "User perform google oauth login", js: true do
  include OmniauthHelpers

  scenario "when user login through google with the right account" do
    user_email = "examplefirstname.lastname@example.com"
    mock_auth_with_user(email: user_email)
    visit user_google_oauth2_omniauth_authorize_path
    expect(find('.session-panel').text).to eq("Examplefirstname")
  end

  scenario "when user login through google with the wrong account" do
    mock_auth_with_invalid_domain
    visit user_google_oauth2_omniauth_authorize_path
    expect(find('.notification').text).to eq("Invalid login")
  end
end
