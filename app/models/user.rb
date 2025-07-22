class User < ApplicationRecord
  has_secure_password
  after_create :welcome_send

  # Cette méthode est appelée par SessionsHelper#remember
  def remember(token)
    self.remember_digest = BCrypt::Password.create(token)
    save(validate: false)
  end

  # Cette méthode permet d'appeler la méthode 'welcome_send' pour envoyer un email de bienvenue
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  belongs_to :city
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :age, presence: true, numericality: { only_integer: true }
  validates :city_id, presence: true
  validates :email, presence: true, uniqueness: true
end
