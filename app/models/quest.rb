class Quest < ApplicationRecord
  validates :name, presence: { message: "Quest name cannot be empty" }
  validates :name, length: { maximum: 100, message: "Quest name is too long" }

  scope :completed, -> { where(status: true) }
  scope :uncompleted, -> { where(status: false) }
end
