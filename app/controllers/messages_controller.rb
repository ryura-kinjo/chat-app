class MessagesController < ApplicationController
  def index
    @rooms = current_user.rooms
  end
end
