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

  validates :name, presence: true, uniqueness:true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  has_many :favorites, dependent: :destroy

  has_many :post_comments, dependent: :destroy
  # 「1」のデータが削除された場合、関連する「N」のデータも削除される設定です。
  # Userのデータが削除されたとき、そのUserが投稿したコメントデータも一緒に削除されます。

  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  has_many :followed_user, through: :followed, source: :follower  # 自分をフォローしている人(自分がフォローされている人)
  has_many :follower_user, through: :follower, source: :followed  # 自分がフォローしている人
  # sourceは関連先モデル名を指定します。
  # フォローする人(follower)は中間テーブル(Relationshipのfollower)を通じて(through)、フォローされる人(followed)と紐づく
  # フォローされる人(followed) は中間テーブル(Relationshipのfollowed)を通じて(through)、 フォローする人(follower) と紐づく
  # ユーザーをフォローする
    def follow(user_id)
     follower.create(followed_id: user_id)
    #  アソシエーションを利用
    end
    # ユーザーのフォローを外す
    def unfollow(user_id)
     follower.find_by(followed_id: user_id).destroy
    end
    # フォロー確認をおこなう
    def following?(user)
     follower_user.include?(user)
    end

  attachment :profile_image 

end
