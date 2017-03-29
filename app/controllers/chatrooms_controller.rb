class ChatroomsController < ApplicationController
  def new
    @chatroom = Chatroom.new
  end

  def show
    # binding.pry
    @chatroom = Chatroom.find_by(id: params[:slug])
    @message = Message.new
  end

  def index
    @chatrooms = Chatroom.all
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      flash[:success] = 'Chat room added!'
      redirect_to chatrooms_path
    else
      render 'new'
    end
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:topic)
  end
end
