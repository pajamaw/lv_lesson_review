class RatingsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:index, :show]

  def index
    @lesson = Lesson.find(params[:lesson_id])
    @ratings = @lesson.ratings
     respond_to do |format|
      format.html {render plain: @ratings}
      format.json { render json: @ratings}
    end  
  end

  def new
    if params[:lesson_id] && !Lesson.exists?(params[:lesson_id])
      flash[:alert] = "Lesson not found."
      redirect_to lessons_path
    else
      @user = User.find_by(id: current_user)
      @rating = Rating.new(lesson_id: params[:lesson_id], user_id: @user.id)
    end
  end

  def create
    @rating = Rating.create(rating_params)
    authorize @rating
    if @rating.save
      flash[:notice] = "Rating Added"
      redirect_to lesson_path( @rating.lesson_id)
    end
  end

  def edit
    if params[:lesson_id]
      lesson = Lesson.find_by(id: params[:lesson_id])
      if lesson.nil?
        flash[:alert] = "Lesson not found"
        redirect_to lessons_path
      else
        @rating = lesson.ratings.find_by(id: params[:id])
      end
    @rating = Rating.find_by(id: params[:id])
    end
  end

  def show
    @lesson = Lesson.find_by(id: params[:lesson_id])
    @user = User.find_by(id: params[:user_id])
    @rating = Rating.find_by(id: params[:id])
    respond_to do |format|
      format.html {render plain: @rating}
      format.json { render json: @rating}
    end  
  end

  def update
    @rating = Rating.find_by(id: params[:id])
    authorize @rating
    @rating.update(rating_params)
    if @rating.save
      flash[:notice] = "Rating Updated"
      redirect_to rating_path(@rating)
    else
      render :edit
    end
  end

  def destroy
    @rating = Rating.find(params[:id])
    authorize @rating
    @rating.destroy
    flash[:notice] = "Rating deleted."
    redirect_to lessons_path
  end

  private

  def rating_params
    params.permit(:star_rating, :lesson_id, :user_id)
  end
end

