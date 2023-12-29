class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :group_id, null: false #グループID
      t.date :start_time, null: false #日時
      t.string :location #場所
      t.integer :classification, null: false #分類
      t.text :content #内容
      t.timestamps
    end
  end
end
