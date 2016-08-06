require "rails_helper"

describe ItemsController, type: :controller do
  describe "#create" do
    render_views

    context "when there is a list" do
      before { List.create! }

      it "should create a new item in the list" do
        post :create, format: :js, params: { item: { name: 'example name' } }
        expect(response.success?).to eq true
      end
    end

    context "when there isn't a list" do
      it "should create a new item in the list" do
        list_count_before_action = List.count
        post :create, format: :js, params: { item: { name: 'example name' } }
        expect(response.success?).to eq true
        expect(List.count).to eq(list_count_before_action + 1)
        expect(List.count).to eq(1)
      end
    end
  end
end
