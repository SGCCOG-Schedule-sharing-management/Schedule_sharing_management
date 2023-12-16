class CreateAchievementFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :achievement_favorites do |t|
      t.integer :user_id
      t.integer :achievement_id
      t.timestamps
    end
  end
end
