require 'pry'
class CommentsController < ApplicationController
  def new
    if logged_in?

      if params[:lesson_id] && !Lesson.exists?(params[:lesson_id])
        flash[:notice] = "Lesson not found."
        redirect_to lessons_path
      else
        @user = User.find_by(id: current_user)
        @comment = Comment.new(lesson_id: params[:lesson_id], user_id: @user.id)
      end
    else
      flash[:alert] = "You must log in to create comments"
      redirect_to(request.referrer || root_path)
    end 
  end

  def create
    if logged_in?
      @comment = Comment.create(comment_params)
      authorize @comment
      flash[:notice] = "Comment Added"
      redirect_to comment_path(@comment)
    else
      flash[:alert] = "You must log in to create comments"
      redirect_to(request.referrer || root_path)
    end
  end

  def edit
    if logged_in?
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
    else
      flash[:alert] = "You must log in to update comments"
      redirect_to(request.referrer || root_path)
    end
  end

  def show
    @lesson = Lesson.find_by(id: params[:lesson_id])
    @user = User.find_by(id: params[:user_id])
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    if logged_in?
      @comment = Comment.find_by(id: params[:id])
      authorize @comment
      @comment.update(comment_params)
      if @comment.save
        flash[:notice] = "Comment Updated"
        redirect_to comment_path(@comment)
      else
        render :edit
      end
    else
      flash[:alert] = "You must log in to update comments"
      redirect_to(request.referrer || root_path)
    end
  end

  def destroy
    if logged_in?
      @comment = Comment.find(params[:id])
      authorize @comment
      @comment.destroy
      flash[:notice] = "Comment deleted."
      redirect_to lessons_path
    else
      flash[:alert] = "You must log in to delete comments"
      redirect_to(request.referrer || root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :lesson_id, :user_id)
  end
end
