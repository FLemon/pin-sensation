class Item < ApplicationRecord
  belongs_to :list
  belongs_to :user

  before_save :assign_name, if: :user

  private

  def assign_name
    self.name = user.name
  end
end
