class Group < ApplicationRecord
  has_many :group_participation_applications, dependent: :destroy
  attribute :actual_date, :date
  attribute :actual_time, :time
  
  def formatted_actual_date
    actual_date.present? ? actual_date : '未定'
  end
end
