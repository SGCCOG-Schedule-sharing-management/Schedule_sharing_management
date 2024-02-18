class Public::AchievementCommentsController < ApplicationController
  
def create
  achievement = Achievement.find(params[:achievement_id])
  comment = achievement.achievement_comments.new(achievement_comment_params)
  comment.user = current_user
  comment.save
  redirect_to achievement_path(achievement)
end

  
  def destroy
    AchievementComment.find(params[:id]).destroy
    redirect_to achievement_path(params[:achievement_id])
  end

  private

  def achievement_comment_params
    params.require(:achievement_comment).permit(:comment)
  end
  
end
