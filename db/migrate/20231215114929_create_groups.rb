class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :title, null: false #タイトル
      t.text :content, null: false #内容
      t.date :actual_date #本番日
      t.time :actual_time #本番時刻
      t.string :production_location #本番場所
      t.timestamps
    end
  end
end
