class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def create
    @publication = Publication.find(params[:id])
    @comment = Comment.new
    @comment.user = current_user
    @comment.publication = @publication
    @comment.save
  end
end
