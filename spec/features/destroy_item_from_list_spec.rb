require 'rails_helper'
require 'omniauth_helpers'

feature "User can destroy item from list", js: true do
  include OmniauthHelpers

  before do
    list = List.create!
    Item.create!(list: list, name: 'example name', content: "example content", comment: "example comment")
    mock_auth_with_user
    visit user_google_oauth2_omniauth_authorize_path
  end

  scenario "when user fill in the form and create an item to the list" do
    page.accept_confirm 'Are you sure' do
      find('li', text: 'example name').find("button[action='delete']").click
    end
    expect(has_css?('li', text: 'example name')).to eq false
  end
end
