class Schedule < ApplicationRecord
  validates :start_time, presence: true
  
  belongs_to :group
  has_many :schedule_participants, dependent: :destroy
  enum classification: { other: 0, announcement: 1, practice: 2 }
end
