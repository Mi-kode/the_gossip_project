class SessionsController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create, :destroy ]

  include SessionsHelper
  def new
    @users = User.new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      # On vérifie si l'utilisateur a coché "Se souvenir de moi"
      if params[:remember_me] == "1"
        # On crée un cookie pour se souvenir de l'utilisateur
        # cookies.permanent.signed[:user_id] = user.id
        remember(user)
      else
        # Sinon, on supprime le cookie s'il existe
        # cookies.delete(:user_id)
        forget(user)
      end

      redirect_to root_path, notice: "Connecté avec succès !"
    else
      flash.now[:error] = "Email ou mot de passe incorrect, veuillez réessayer"
      render :new
    end
  end

  def destroy
    # On appelle log_out

    log_out(current_user) if current_user
    redirect_to root_path, notice: "Déconnecté avec succès !"
  end
end
