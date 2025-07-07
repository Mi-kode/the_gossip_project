class Gossip < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  validates :title, presence: true, length: {in: 3..14}
  validates :content, presence: true
end
