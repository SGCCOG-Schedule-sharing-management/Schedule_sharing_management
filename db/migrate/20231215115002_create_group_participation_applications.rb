class CreateGroupParticipationApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :group_participation_applications do |t|
      t.integer :user_id, null: false #ユーザーID
      t.integer :group_id, null: false #グループID
      t.string :title #タイトル
      t.text :comment #コメント
      t.integer :application_status, null: false, default: 0 #申請ステータス
      t.timestamps
    end
  end
end
