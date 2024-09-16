class Transaction < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  belongs_to :category, foreign_key: :category_id
  validates :amount, presence: true
end
