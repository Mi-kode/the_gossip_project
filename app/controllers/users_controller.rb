class UsersController < ApplicationController
  before_action :require_login, only: [ :new, :create ]

  def require_login
    unless logged_in?
      flash[:error] = "Tu dois être connecté pour accéder à cette page"
      redirect_to login_path
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @users = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      age: params[:age],
      city: params[:city],
      email: params[:email],
      password: params[:password]
    )

    if @users.save
      flash[:success] = "Votre compte a été créé avec succès !"
      redirect_to root_path
    else
      flash.now[:error] = "Oups... il y a eu une erreur !"
      render :new
    end
  end
end
