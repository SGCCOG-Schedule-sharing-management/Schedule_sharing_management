class CreateScheduleParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :schedule_participants do |t|
      t.integer :user_id, null: false #ユーザーID
      t.integer :schedule_id, null: false #予定ID
      t.date :date, null: false #日
      t.time :time #時刻
      t.integer :attendance_status, null: false, dafault: 0 #出欠ステータス
      t.timestamps
    end
  end
end
