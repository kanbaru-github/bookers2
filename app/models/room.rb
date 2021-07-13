class Room < ApplicationRecord
  # ユーザー同士が会話をする部屋

  has_many :user_rooms
  has_many :chats

end
