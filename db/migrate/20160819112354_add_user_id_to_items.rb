class AddUserIdToItems < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.references :user
    end
  end
end
