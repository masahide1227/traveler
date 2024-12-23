class ChatRoom < ApplicationRecord
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'
  has_many :messages, dependent: :destroy

  # チャットルームの名前を生成するメソッド
  def name
    "#{user1.name} and #{user2.name}'s Chat Room"
  end

  # 2人のユーザー間のチャットルームを探し、なければ新規作成するメソッド
  def self.find_or_create_by_users(user1, user2)
    # IDの小さい方をuser1、大きい方をuser2にして順序を統一
    user1, user2 = [user1, user2].sort_by(&:id)

    # 既存のチャットルームがあるか検索し、なければ作成する
    ChatRoom.find_by(user1: user1, user2: user2) || ChatRoom.create(user1: user1, user2: user2)
  end
end

