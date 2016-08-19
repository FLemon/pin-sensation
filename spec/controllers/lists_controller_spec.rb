require "rails_helper"

describe ListsController, type: :controller do
  describe "#show" do
    let(:user_1) { User.create!(email:'example1@example.com', name:'example name 1', password: 'password') }
    let(:user_2) { User.create!(email:'example2@example.com', name:'example name 2', password: 'password') }

    render_views

    context "when there is a list" do
      it "should have correct response" do
        list = List.create!
        Item.create!(list: list, user: user_1, content: "example content", comment: "example comment")
        Item.create!(list: list, user: user_2, content: "example content", comment: "example comment")

        get :show
        expect(response.body).to match(/example name 1/)
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
