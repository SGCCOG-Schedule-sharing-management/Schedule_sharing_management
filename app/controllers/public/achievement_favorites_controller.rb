class Public::AchievementFavoritesController < ApplicationController
  
  def create
    achievement = Achievement.find(params[:achievement_id])
    favorite = current_user.achievement_favorites.new(achievement_id: achievement.id)
    favorite.save
    redirect_to achievement_path(achievement)
  end


  def destroy
    achievement = Achievement.find(params[:achievement_id])
    favorite = current_user.achievement_favorites.find_by(achievement_id: achievement.id)
    favorite.destroy
    redirect_to achievement_path(achievement)
  end
  
end
