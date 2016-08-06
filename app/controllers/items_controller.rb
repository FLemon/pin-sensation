class ItemsController < ApplicationController
  #xoxb-66734971440-vDCyCHjPD9s5ofslVyjE2mUn
  def create
    list = List.last || List.create!
    item = Item.create!(item_params.merge({list: list}))

    ActionCable.server.broadcast 'items',
      name: item.name,
      content: item.content,
      comment: item.comment
    head :ok
  end

  private

  def item_params
    params.require(:item).permit(:name)
  end
end
