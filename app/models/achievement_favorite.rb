class AchievementFavorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :achievement
  
  # user_idとachievement_idのペアが一意である（重複しない）状態に制限
  validates :user_id, uniqueness: {scope: :achievement_id}
  
end
