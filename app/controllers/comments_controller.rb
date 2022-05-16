# frozen_string_literal: true

# post-comments controller
class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update edit]

  before_action :authorize_poster!, only: %i[edit update]

  def new
    @comment = Comment.new
    @post_id = params[:post_id]
  end

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html do
          redirect_to @comment.post, notice: 'Comment was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(:post_id, :content)
      .merge(user: current_user)
  end
end
