class ListsController < ApplicationController
  def show
    @list = List.last
  end
end
