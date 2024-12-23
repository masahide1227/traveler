class MessagesController < ApplicationController
    before_action :set_chat_room
    before_action :check_mutual_follow, only: [:create]
  
    def create
      @message = @chat_room.direct_messages.build(direct_message_params)
      @message.user = current_user
  
      if @message.save
        redirect_to @chat_room
      else
        render 'chat_rooms/show'
      end
    end
  
    private
  
    def set_chat_room
      @chat_room = ChatRoom.find(params[:chat_room_id])
    end
  
    def direct_message_params
      params.require(:direct_message).permit(:content)
    end
  
    # 相互フォローしていない場合、メッセージ送信を制限
    def check_mutual_follow
      other_user = @chat_room.other_user(current_user)
      unless current_user.mutual_follow?(other_user)
        flash[:alert] = "相互フォローしていないため、DMを送信できません。"
        redirect_to chat_rooms_path
      end
    end
  end