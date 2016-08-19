require 'rails_helper'
require 'omniauth_helpers'

feature "User can destroy item from list", js: true do
  include Warden::Test::Helpers
  Warden.test_mode!

  let(:user) { User.create!(name: "example name#{Random.rand(100)}", email: 'first.last@example.com', password: 'password') }
  let(:another_user) { User.create!(name: "example name#{Random.rand(100)}", email: 'first.last2@example.com', password: 'password') }
  let(:list) { List.create! }

  before { login_as user, scope: :user }

  scenario "can destroy item that belongs to the user" do
    Item.create!(list: list, user: user, content: "example content", comment: "example comment")
    visit '/list'
    page.accept_confirm 'Are you sure' do
      find('li', text: user.name).find("button[action='delete']").click
    end
    expect(has_no_css?('li', text: user.name)).to eq true
  end

  scenario "can not destroy item that does not belongs to the user" do
    Item.create!(list: list, user: another_user, content: "example content", comment: "example comment")
    visit '/list'
    within('li', text: another_user.name) do
      expect(has_no_css?("button[action='delete']")).to eq true
    end
  end
end
