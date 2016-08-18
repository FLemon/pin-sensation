class CreateUserOmniauth < ActiveRecord::Migration[5.0]
  def change
    create_table :user_omniauths do |t|
      t.references :user
      t.string :uid
      t.string :provider
    end
  end
end
