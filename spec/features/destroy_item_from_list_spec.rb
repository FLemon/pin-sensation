require 'rails_helper'

feature "User can destroy item from list", js: true do
  before { visit '/list' }

  scenario "when user fill in the form and create an item to the list" do
    fill_in 'item_name', with: 'feature example name'
    fill_in 'item_content', with: 'feature example content'
    fill_in 'item_comment', with: 'feature example comment'
    find('#submit-new-item').click

    page.accept_confirm 'Are you sure' do
      find('li', text: 'feature example name').find("button[action='delete']").click
    end
    expect(has_css?('li', text: 'feature example name')).to eq false
  end
end
