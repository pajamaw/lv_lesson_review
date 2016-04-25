class CommentsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:show]  
  
  def new
    if params[:lesson_id] && !Lesson.exists?(params[:lesson_id])
      flash[:alert] = "Lesson not found."
      redirect_to lessons_path
    else
      @user = User.find_by(id: current_user)
      @comment = Comment.new(lesson_id: params[:lesson_id], user_id: @user.id)
    end
  end

  def create
    @comment = Comment.create(content: params[:content], lesson_id: params[:lesson_id], user_id: params[:user_id])
    authorize @comment
    if @comment.save
      flash[:notice] = "Comment Added"
      redirect_to lesson_path(@comment.lesson_id)
    end
  end

  def edit
    if params[:lesson_id]
      lesson = Lesson.find_by(id: params[:lesson_id])
      if lesson.nil?
        flash[:alert] = "Lesson not found"
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
    respond_to do |format|
      format.json { render json: @comment}
    end  
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.update(comment_params)
    if @comment.save
      flash[:notice] = "Comment Updated"
      redirect_to lesson_path(@comment.lesson_id)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    flash[:notice] = "Comment deleted."
    redirect_to lessons_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :lesson_id, :user_id)
  end
end
