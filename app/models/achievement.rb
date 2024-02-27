class Achievement < ApplicationRecord
  belongs_to :schedule
  belongs_to :user, optional: true  # ユーザーが削除された場合でも投稿情報は残す
  has_one_attached :post_image
  has_many :achievement_favorites, dependent: :destroy
  has_many :achievement_comments, dependent: :destroy
  
  def favorited_by?(user)
    achievement_favorites.exists?(user_id: user.id)
  end

  
end
