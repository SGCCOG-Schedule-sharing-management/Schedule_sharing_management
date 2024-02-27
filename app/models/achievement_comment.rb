class AchievementComment < ApplicationRecord

  belongs_to :user
  belongs_to :achievement
  has_one_attached :post_image
    
end
