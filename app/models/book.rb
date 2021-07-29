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
  has_many :favorited_users, through: :favorites, source: :user
  # favorited_usersは、favoritesテーブルを通って、userモデルのデータ持ってくる
  # 中間テーブルは多対多の関係を表現するためのテーブルのこと

  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  # lengthとは属性の値の長さを検証しています。今回は文字数


  def Book.search(search_word)
    Book.where(['category LIKE ?', "#{search_word}"])
  end

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  # scopeとは複数のクエリ（処理要求）をまとめたメソッド
  # def created_at
  # where()
  # end  と同じ
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) } # 2日前
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) } # 3日前
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) } # 4日前
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) } # 5日前
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) } # 6日前
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } #今週
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } # 前週

  has_many :view_counts, dependent: :destroy


end
