class User < ApplicationRecord
  has_secure_password

  # Cette méthode est appelée par SessionsHelper#remember
  def remember(token)
    self.remember_digest = BCrypt::Password.create(token)
    save(validate: false)
  end

  belongs_to :city
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :age, presence: true, numericality: { only_integer: true }
  validates :city_id, presence: true
  validates :email, presence: true, uniqueness: true
end
