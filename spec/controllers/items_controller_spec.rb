require "rails_helper"

describe ItemsController, type: :controller do
  describe "#destroy" do
    let(:list) { List.create! }
    let!(:item) { Item.create!(list: list, name: "example name", content: "example content", comment: "example comment") }

    it "should remove an item from the list" do
      expect do
        delete :destroy, params: { item: { id: item } }
      end.to change{ Item.count }.from(1).to(0)
      expect(response.success?).to eq true
      expect(response.status).to eq 200
    end
  end

  describe "#create" do
    context "when there is a list" do
      before { List.create! }

      it "should create a new item in the list" do
        expect do
          post :create, format: :js, params: { item: { name: 'example name' } }
        end.to change{ List.count }.by(0)
        expect(response.success?).to eq true
        expect(response.status).to eq 200
      end
    end

    context "when there isn't a list" do
      it "should create a new item in the list" do
        expect do
          post :create, format: :js, params: { item: { name: 'example name' } }
        end.to change{ List.count }.from(0).to(1)
        expect(response.success?).to eq true
        expect(response.status).to eq 200
      end
    end
  end
end
