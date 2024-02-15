class Achievement < ApplicationRecord
  belongs_to :schedule
  belongs_to :user, dependent: :destroy
  has_one_attached :post_image
end
