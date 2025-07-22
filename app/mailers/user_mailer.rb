class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = "http://thegossipproject.fr/login"
    mail(to: @user.email, subject: "Bienvenue chez The Gossip Project")
  end

  def password_reset_email(user)
    @user = user
    mail(to: @user.email, subject: "Réinitialisation de votre mot de passe")
  end
end
