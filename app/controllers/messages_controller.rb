class MessagesController < ApplicationController
  def index
    @rooms = current_user.rooms
    @current_room = Room.find_by(id: params[:room_id])
    @messages = @current_room.messages.includes(:user)
    @message = Message.new
    # binding.pry
  end

  def create
    room = Room.find(params[:room_id])
    message = room.messages.new(message_params)
    
    if message.save
      redirect_to room_messages_path(room)
    else
      @messages = room.messages.includes(:user)
      @message = Message.new
      @rooms = current_user.rooms
      @current_room = Room.find_by(id: params[:room_id])
      render :index, status: :unprocessable_entity
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

end
