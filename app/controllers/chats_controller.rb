class ChatsController < ApplicationController

  before_action :follow_each_other, only: [:show]

  def show
    @user = User.find(params[:id])
    # どのユーザーとチャットするかを取得
    rooms = current_user.user_rooms.pluck(:room_id)
    # pluckは、1つのモデルで使用されているテーブルからカラム (1つでも複数でも可) を取得するクエリを送信するのに使用
    # カレントユーザーのuser_roomにあるroom_idの値の配列をroomsに代入
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    # user_roomモデルからuser_idがチャット相手のidが一致するものと、room_idが上記roomsのどれかに一致するレコードをuser_roomsに代入
    unless user_rooms.nil?
      # もしuser_roomが空でないなら
      @room = user_rooms.room
      # @roomに上記user_roomのroomを代入
    else
      @room = Room.new
      # それ以外は新しくroomを作り
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      # user_roomをカレントユーザー分とチャット相手分を作る
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def follow_each_other
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to books_path
    end
  end

end
