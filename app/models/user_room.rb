class UserRoom < ApplicationRecord
  # userとroomが多対多の関係性のため、中間テーブルとしてこれを管理

  belongs_to :user
  belongs_to :room

end
