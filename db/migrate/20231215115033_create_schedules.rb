class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :group_id, null: false #グループID
      t.date :date, null: false #日
      t.time :time #時刻
      t.string :location #場所
      t.text :belongings #持ち物
      t.timestamps
    end
  end
end
