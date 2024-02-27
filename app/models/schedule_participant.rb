class ScheduleParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  #belongs_to :achievement
  
  validates :user_id, uniqueness: {scope: :schedule_id}
  
  #enum→未定:0、参加:1、不参加:2
  enum attendance_status: { pending: 0, joining: 1, abstention: 2 }
end
