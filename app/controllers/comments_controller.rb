require 'pry'
class CommentsController < ApplicationController
  def new
    if params[:lesson_id] && !Lesson.exists?(params[:lesson_id])
      flash[:notice] = "Lesson not found."
      redirect_to lessons_path
    else
      @user = User.find_by(id: current_user)
      @comment = Comment.new(lesson_id: params[:lesson_id], user_id: @user.id)
    end
  end

  def create
    #@comment = Comment.new(user_id: @user.id)
    #if @comment.save
   
    @comment = Comment.create(comment_params)
    flash[:notice] = "Comment Added"
    redirect_to comment_path(@comment)
  end

  def edit
    if params[:lesson_id]
      lesson = Lesson.find_by(id: params[:lesson_id])
      if lesson.nil?
        flash[:notice] = "Lesson not found"
        redirect_to lessons_path
      else
        @comment = lesson.comments.find_by(id: params[:id])
      end
    @comment = Comment.find_by(id: params[:id])
    end
  end

  def show
    @lesson = Lesson.find_by(id: params[:lesson_id])
    @user = User.find_by(id: params[:user_id])
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    @comment.update(comment_params)
    if @comment.save
      flash[:notice] = "Comment Updated"
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :lesson_id, :user_id)
  end
end
