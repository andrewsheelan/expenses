class Category < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates :user_id, presence: true

  scope :search, ->(query) {
    return all if query.blank?

    where("lower(name) LIKE :query OR lower(description) LIKE :query", query: "%#{query.downcase}%")
  }
end
