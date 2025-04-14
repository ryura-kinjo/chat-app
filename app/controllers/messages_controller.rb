class MessagesController < ApplicationController
  def index
    @rooms = current_user.rooms
    @current_room = Room.find_by(id: params[:room_id])
    @message = Message.new
  end

  def create
    room = Room.find(params[:user_id])
    message = room.message.new(message_params)
    if message.save
      redirect_to room_messages_path(room)
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end

end
