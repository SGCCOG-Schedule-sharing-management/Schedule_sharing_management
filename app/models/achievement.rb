class Achievement < ApplicationRecord
  belongs_to :schedule
  belongs_to :schedule_participant
  has_many :users, dependent: :destroy
end
