class UsersController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create, :show ]
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
