require "rails_helper"

describe ListsController, type: :controller do
  describe "#show" do
    render_views

    it "should have correct response" do
      list = List.create!
      Item.create!(list: list, name: "example name", content: "example content", comment: "example comment")
      Item.create!(list: list, name: "example name 2", content: "example content", comment: "example comment")

      get :show
      expect(response.body).to match(/example name/)
      expect(response.body).to match(/example name 2/)
    end
  end
end
