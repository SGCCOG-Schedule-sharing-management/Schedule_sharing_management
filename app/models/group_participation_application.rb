class GroupParticipationApplication < ApplicationRecord
  #has_many :users, dependent: :destroy
  belongs_to :group
  belongs_to :user  # ユーザーが削除された場合にグループ申請も同時に削除される
  # group が存在することを検証するバリデーション
  validates :group, presence: true
  
#0:未処理、1:承認、2:却下
enum application_status: { untreated: 0, approved: 1, rejected: 2 }
end
