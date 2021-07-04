class Relationship < ApplicationRecord

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  # followerやfollwedというモデルは存在しないが、class_nameを使ってモデルを指定すればモデル名と異なる関連付け名を指定することができる。

  validates :follower_id, presence: true
  validates :followed_id, presence: true

end
