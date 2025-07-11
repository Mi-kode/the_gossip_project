class SessionsController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create, :destroy ]
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
