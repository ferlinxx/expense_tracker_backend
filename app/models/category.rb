class Category < ApplicationRecord
  validates :name, presence: true
  has_many :transactions, foreign_key: :category_id
end
