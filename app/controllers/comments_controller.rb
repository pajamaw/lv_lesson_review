require 'pry'
class CommentsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(id: current_user)
    @lesson = Lesson.find_by(id: params[:lesson_id])
    @comment= Comment.create(user_id: @user.id, lesson_id: params[:lesson_id], content: params[:content])
    flash[:notice] = "Comment Added"
    redirect_to lesson_path(@lesson)
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @lesson = Lesson.find_by(id: @comment.lesson_id)
    @comment.update(content: params[:content])
    redirect_to comment_path(@comment)
  end


end
