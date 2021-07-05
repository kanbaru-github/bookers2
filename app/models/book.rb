class Book < ApplicationRecord

  def self.search_for(keyword, method)
    if method == '完全一致'
      Book.where(title: keyword)
    elsif method == '前方一致'
      Book.where('title LIKE ?', keyword + '%')
    elsif method == '後方一致'
      Book.where('title LIKE ?', '%' + keyword)
    else
      Book.where('title LIKE ?', '%' + keyword + '%')
    end
  end

  belongs_to :user

  has_many :favorites, dependent: :destroy
  def favorited_by?(user)
    # このメソッドで、引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べる
    # 存在していればtrue、存在していなければfalseを返すようにしています。
    favorites.where(user_id: user.id).exists?
  end

  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
