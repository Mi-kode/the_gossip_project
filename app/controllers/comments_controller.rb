class CommentsController < ApplicationController
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
    anonymous = User.find_by(first_name: "anonymous")
    @comment = @gossip.comments.build(content: params[:content], user: anonymous)
    if @comment.save
      redirect_to gossip_path(@gossip), notice: "Commentaire ajouté !"
    else
      render :new
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
