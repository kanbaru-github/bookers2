class Book < ApplicationRecord

  belongs_to :user

  has_many :favorites, dependent: :destroy
  def favorited_by?(user)
    # このメソッドで、引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べます。
    # 存在していればtrue、存在していなければfalseを返すようにしています。
    favorites.where(user_id: user.id).exists?
  end

  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

end
