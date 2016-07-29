class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.all
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      render @chatroom
    else
      redirect_back(fallback_location: new_chatroom_url)
    end
  end

  def show
    @chatroom = Chatroom.find_by(id: params[:id])
    @message = Message.new
  end

  def chatroom_params
    params.require(:chatroom).permit(:topic)
  end
end
