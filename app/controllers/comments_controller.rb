class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:notice] = 'El comentario ha sido creado con éxito'
    else
      flash[:alert] = 'El comentario no ha sido almacenado'
    end
    redirect_to @comment.post
    # redirect_to post_path(@comment.post) Same as the above
  end

  private
    def comment_params
      params.require(:comment).permit(:author, :post_id, :content)
    end
end
