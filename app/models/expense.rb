class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true
  validates :category, presence: true
end
