class Achievement < ApplicationRecord
  belongs_to :schedule
  belongs_to :schedule_participant
  has_many :users, dependent: :destroy
  has_one_attached :post_image
end
