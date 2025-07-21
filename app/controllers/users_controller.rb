class UsersController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create, :show ]
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      flash[:success] = "Votre compte a été créé avec succès !"
      redirect_to root_path
    else
      flash.now[:error] = "Oups... il y a eu une erreur !"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Vous avez modifié votre compte !"
    else
      render :edit
    end
  end

  def remember(remember_token)
    remember_digest = BCrypt::Password.create(remember_token)
    self.update(remember_digest: remember_digest)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :city_id, :email, :password, :password_confirmation)
  end
end
