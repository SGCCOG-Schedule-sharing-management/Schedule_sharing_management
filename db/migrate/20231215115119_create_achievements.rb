class CreateAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :achievements do |t|
      t.integer :schedule_id, null: false #予定ID
      t.integer :user_id, null: false #ユーザーID
      t.integer :schedule_participant_id #参加予定者ID
      t.string :title, null: false #タイトル
      t.string :participant #参加メンバー
      t.text :content #内容
      t.text :comment #コメント
      t.timestamps
    end
  end
end
