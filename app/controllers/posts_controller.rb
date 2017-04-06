class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :show, :index ]
  before_action :is_admin?, only: [ :new, :create, :edit, :update, :destroy ]

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
      @users = User.all

      @users.each do |user|
        UserNotifierMailer.new_post_mail(user, @post).deliver_now
      end

      flash[:notice] = 'El post ha sido creado con éxito'
      redirect_to posts_path
    else
      flash[:alert] = 'Algo fallo, el post no ha sido creado con éxito'
      render :new
    end
  end

  def new_post_modal
    @post = Post.new
  end

  def search_by_title
    posts = Post.all
    # With Postgress
    @posts = posts.where("title ILIKE ?", "%#{params[:title]}%")
    # With SQLite3
    # @posts = posts.where("title LIKE '%#{params[:title]}%'")

    render :index
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:author, :title, :content)
    end

    def is_admin?
      unless current_user.admin?
        flash[:alert] = 'No tienes permisos para acceder a esta ruta'
        redirect_to root_path
      end
    end
end
