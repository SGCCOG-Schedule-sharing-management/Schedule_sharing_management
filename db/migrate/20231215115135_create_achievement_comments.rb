class CreateAchievementComments < ActiveRecord::Migration[6.1]
  def change
    create_table :achievement_comments do |t|
      t.integer :user_id, null: false #ユーザーID
      t.integer :achievement_id, null: false #実績ID
      t.text :comment, null: false #コメント
      t.timestamps
    end
  end
end
