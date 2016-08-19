require "rails_helper"

describe ItemsController, type: :controller do
  let(:user) { User.create!(email:'example@example.com', name:'example name', password: 'password') }

  before do
    sign_in(user)
  end

  describe "#destroy" do
    let(:list) { List.create! }

    context "when the item belongs to the logedin user" do
      let!(:item) { Item.create!(list: list, user: user, content: "example content", comment: "example comment") }

      it "allow to remove the item" do
        expect do
          delete :destroy, params: { item: { id: item } }
        end.to change{ Item.count }.from(1).to(0)
        expect(response.success?).to eq true
        expect(response.status).to eq 200
      end
    end

    context "when the item belongs to again user" do
      let(:another_user) { User.create!(email:'example1@example.com', name:'example name 1', password: 'password') }
      let!(:item) { Item.create!(list: list, user: another_user, content: "example content", comment: "example comment") }

      it "not allow remove the item" do
        expect do
          delete :destroy, params: { item: { id: item } }
        end.to change{ Item.count }.by(0).
        and raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#create" do
    render_views

    context "when there is a list" do
      before { List.create! }

      it "should create a new item in the list" do
        expect do
          post :create, format: :js, params: { item: { content: 'example content' } }
        end.to change { List.count }.by(0).
        and change{ Item.count }.from(0).to(1)

        expect(response.success?).to eq true
        expect(response.status).to eq 200
        expect(response.body).to match(/#{user.name}/)
      end
    end

    context "when there isn't a list" do
      it "should create a new item in the list" do
        expect do
          post :create, format: :js, params: { item: { content: 'example content' } }
        end.to change{ List.count }.from(0).to(1).
        and change{ Item.count }.from(0).to(1)

        expect(response.success?).to eq true
        expect(response.status).to eq 200
        expect(response.body).to match(/#{user.name}/)
      end
    end
  end
end
