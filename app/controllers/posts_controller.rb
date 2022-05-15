# frozen_string_literal: true

# Controls posts
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  before_action :authorize_poster!, only: %i[edit update destroy]
  def index
    @posts = Post.homepage(params[:page])
  end

  # GET /posts/1
  def show
    @comments = @post.comments.includes(:user).order(created_at: :asc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(user: current_user))

    respond_to do |format|
      if @post.save
        format.html do
          redirect_to @post, notice: 'Post was created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
