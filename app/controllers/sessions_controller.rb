class SessionsController < ApplicationController
  before_action :require_login, only: [ :new, :create, :destroy ]

  def require_login
    unless logged_in?
      flash[:error] = "Tu dois être connecté pour accéder à cette page"
      redirect_to login_path
    end
  end
  def new
    @users = User.new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Connecté avec succès !"
    else
      flash.now[:error] = "Email ou mot de passe incorrect, veuillez réessayer"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Déconnecté avec succès !"
  end
end
