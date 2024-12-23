class ChatRoomsController < ApplicationController
  def index 
    @chat_rooms = ChatRoom.all 
  end 
  
  def show 
    @chat_room = ChatRoom.find(params[:id]) 
  end 
  
  def create 
    @chat_room = ChatRoom.find_or_create_by_users(current_user, @user) 
    redirect_to chat_room_path(@chat_room) 
  end 
  
  def destroy 
    @chat_room = ChatRoom.find(params[:id]) 
    @chat_room.destroy 
    redirect_to chat_rooms_path 
  end
end
