class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.search_for(keyword, method)
    if method == '完全一致'
      User.where(name: keyword)
    elsif method == '前方一致'
      User.where('name LIKE ?', keyword + '%')
    elsif method == '後方一致'
      User.where('name LIKE ?', '%' + keyword)
    else
      User.where('name LIKE ?', '%' + keyword + '%')
    end
  end

  has_many :books, dependent: :destroy

  attachment :profile_image, destroy: false
  # userモデルが消えてもrefileに残る

  validates :name, presence: true, uniqueness:true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  has_many :favorites, dependent: :destroy

  has_many :post_comments, dependent: :destroy
  # 「1」のデータが削除された場合、関連する「N」のデータも削除される設定です。
  # Userのデータが削除されたとき、そのUserが投稿したコメントデータも一緒に削除されます。

  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # relaitonshipsの「逆方向」という意味
  # class_nameで「reverse_of_relationshipsではなくrelationsipモデルの事だよ」と設定
  # foreign_key指定により、relationshipsテーブルのどのカラムを参照するのかを指定します。
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # throughは「中間テーブルはrelationships_of_relationshipsだよ」って設定
  # source:followは「relationships_of_relationshipsテーブルのfollow_idを参考にして、followersモデルにアクセスしてね」という意味
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  # Userモデルにメソッドを記述
   # ユーザーをフォローする
  def follow(user_id)
    # user_idは動作する際に一時的に作られる為schemaにはない
    relationships.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
    # find_by返ってくる結果は、最初にヒットした1件のみ
  end

  # フォロー確認を行う
  def following?(user)
    followings.include?(user)
    # nclude?は対象の配列に引数のものが含まれていればtrue、含まれていなければfalseを返します。
  end

  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  has_many :view_counts, dependent: :destroy

  has_many :group_users
  has_many :groups, through: :group_users

end
