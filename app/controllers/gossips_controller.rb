class GossipsController < ApplicationController
  def show
    @gossip = Gossip.find(params[:id])
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
    anonymous = User.find_by(first_name: "anonymous")
    @gossip = Gossip.new(
      title: params[:title],
      content: params[:content],
      user: anonymous
    )

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
      redirect_to gossip_path(@gossip), notice: "Gossip successfully updated!"
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
