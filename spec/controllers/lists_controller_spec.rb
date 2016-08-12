require "rails_helper"

describe ListsController, type: :controller do
  describe "#show" do
    render_views

    context "when there is a list" do
      it "should have correct response" do
        list = List.create!
        Item.create!(list: list, name: "example name", content: "example content", comment: "example comment")
        Item.create!(list: list, name: "example name 2", content: "example content", comment: "example comment")

        get :show
        expect(response.body).to match(/example name/)
        expect(response.body).to match(/example name 2/)
      end
    end

    context "when there is no list" do
      it "should have correct response" do
        get :show
        expect(response.success?).to eq true
      end
    end
  end
end
