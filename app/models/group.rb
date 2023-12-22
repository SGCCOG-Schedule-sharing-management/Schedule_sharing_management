class Group < ApplicationRecord
  attribute :actual_date, :date
  attribute :actual_time, :time
  
  def formatted_actual_date_and_time
    actual_date_and_time.present? ? actual_date_and_time : '未定'
  end
end
