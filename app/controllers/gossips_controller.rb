class GossipsController < ApplicationController
  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
    @gossip = Gossip.new
  end

  def create
    anonymous = User.find_by(first_name: 'anonymous')
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
end
