require 'rails_helper'

feature "User can add item to list", js: true do
  before { visit '/list' }

  scenario "when user fill in the form and create an item to the list" do
    fill_in 'item_name', with: 'feature example name'
    fill_in 'item_content', with: 'feature example content'
    fill_in 'item_comment', with: 'feature example comment'
    find('#submit-new-item').click

    expect(find('li', text: 'feature example name')).to_not be_nil
  end
end
