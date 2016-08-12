class ItemsController < ApplicationController
  #xoxb-66734971440-vDCyCHjPD9s5ofslVyjE2mUn
  def create
    list = List.last || List.create!
    item = Item.create!(params_for_create.merge({ list: list }))

    ActionCable.server.broadcast 'items',
      action: 'create',
      template: render(partial: 'lists/list_item', locals: { item: item })
    head :ok
  end

  def destroy
    item = Item.find(params_for_destroy)
    item.destroy!
    ActionCable.server.broadcast 'items',
      action: 'destroy',
      item: { id: item.id }
    head :ok
  end

  private

  def params_for_destroy
    params.require(:item).permit(:id).fetch(:id)
  end

  def params_for_create
    params.require(:item).permit(:name, :content, :comment)
  end
end
