require 'rails_helper'
require 'omniauth_helpers'

feature "User can add item to list", js: true do
  include OmniauthHelpers

  let(:user_name) { "example first name" }

  before do
    mock_auth_with_user(name: user_name)
    visit user_google_oauth2_omniauth_authorize_path
  end

  scenario "when user fill in the form and create an item to the list" do
    fill_in 'item_content', with: 'feature example content'
    fill_in 'item_comment', with: 'feature example comment'
    find('#submit-new-item').click

    expect(find('li', text: user_name)).to_not be_nil
  end
end
