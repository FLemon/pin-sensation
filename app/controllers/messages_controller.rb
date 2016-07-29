class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    message.user = User.first
    if message.save
      ActionCable.server.broadcast 'messages',
        message: message.body,
        user: message.user.name
      head :ok
    else
      render json: message.errors
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :chatroom_id)
  end
end
