class CommentsController < ApplicationController
  before_action :require_login, only: [ :new, :create, :edit, :update, :destroy ]

  def require_login
    unless logged_in?
      flash[:error] = "Tu dois être connecté pour accéder à cette page"
      redirect_to login_path
    end
  end
  def new
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comments = @gossip.comments
  end

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to gossip_path(@gossip), notice: "Commentaire ajouté !"
    else
      @comments = @gossip.comments # Important pour réafficher la liste
      render "gossips/show", status: :unprocessable_entity
    end
  end

  def edit
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to gossip_path(@gossip), notice: "Commentaire modifié"
    end
  end

  def destroy
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.find(params[:id])
    @comment.destroy
    redirect_to gossip_path(@gossip), notice: "Commentaire supprimé !"
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
