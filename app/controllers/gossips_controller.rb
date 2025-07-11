class GossipsController < ApplicationController
  before_action :require_login, except: [ :index, :show ]

  def require_login
    unless logged_in?
      flash[:error] = "Tu dois être connecté pour accéder à cette page"
      redirect_to login_path
    end
  end
  def show
    @gossip = Gossip.find(params[:id])
    @comments = @gossip.comments
  end

  def new
    @gossip = Gossip.new
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def index
    @gossips = Gossip.all
  end


  def create
    @gossip = Gossip.new(gossip_params)
    @gossip.user = current_user

    if @gossip.save
      flash[:success] = "Gossip enregistré !"
      redirect_to root_path
    else
      flash.now[:error] = "Oups... il y a eu une erreur !"
      render :new
    end
  end

  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update(gossip_params)
      redirect_to gossip_path(@gossip), notice: "Gossip modifié !"
    else
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to root_path, notice: "Le potin a bien été supprimé."
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end
end
