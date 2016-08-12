class ListsController < ApplicationController
  def show
    @list = List.last || List.create!
  end
end
