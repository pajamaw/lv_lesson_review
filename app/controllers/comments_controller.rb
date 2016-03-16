require 'pry'
class CommentsController < ApplicationController
  def create
    @user = User.find_by(id: current_user)
    @lesson = Lesson.find_by(id: params[:lesson_id])
    @comment= Comment.create(user_id: @user.id, lesson_id: params[:lesson_id], content: params[:content])
    flash[:notice] = "Comment Added"
    redirect_to lesson_path(@lesson)
  end
end
