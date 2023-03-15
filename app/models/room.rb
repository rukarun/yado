class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations

  has_one_attached :room_image

  validates :room_name, :room_introduction, :price, :address, presence: true
end
