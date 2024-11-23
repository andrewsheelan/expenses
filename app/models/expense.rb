class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true

  scope :search, ->(query) {
    return all if query.blank?

    where("lower(title) LIKE :query OR title LIKE :query OR amount LIKE :query", query: "%#{query.downcase}%")
      .or(where(category_id: Category.where("lower(name) LIKE :query", query: "%#{query.downcase}%")))
  }
  validates :category, presence: true
end
