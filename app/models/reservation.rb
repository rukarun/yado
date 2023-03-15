class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validate :start_end_check

  def start_end_check
    errors.add(:end_date, "は開始日より前の日付は登録できません。") unless
    self.start_date <= self.end_date 
  end
end
