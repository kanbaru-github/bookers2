class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  has_many :favorites, dependent: :destroy

  has_many :post_comments, dependent: :destroy
  # 「1」のデータが削除された場合、関連する「N」のデータも削除される設定です。
  # Userのデータが削除されたとき、そのUserが投稿したコメントデータも一緒に削除されます。

  attachment :profile_image

  validates :name, presence: true, uniqueness:true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

end
