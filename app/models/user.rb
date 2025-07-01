class User < ApplicationRecord
  validates :email, presence: true
  belongs_to :city
  has_many :gossips
  has_many :comments
end
