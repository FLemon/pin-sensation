class ListsController < ApplicationController
  def show
    @list = List.last
    @placeholder_item = Item.new(name:'name_placeholder', content: 'content_placeholder', comment: 'comment_placeholder')
  end
end
