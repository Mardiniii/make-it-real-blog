class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :show, :index ]

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = 'El post ha sido actualizado con éxito'
      redirect_to posts_path
    else
      flash[:alert] = 'Algo fallo, el post no ha sido actualizado con éxito'
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy
    flash[:notice] = 'El post ha sido eliminado'
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = 'El post ha sido creado con éxito'
      redirect_to posts_path
    else
      flash[:alert] = 'Algo fallo, el post no ha sido creado con éxito'
      render :new
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:author, :title, :content)
    end
end
