class RatingsController < ApplicationController

  def index
    @lesson = Lesson.find(params[:lesson_id])
    @ratings = @lesson.ratings
    render template: 'ratings/index'
  end

   def new
    if logged_in? 

      if params[:lesson_id] && !Lesson.exists?(params[:lesson_id])
        flash[:notice] = "Lesson not found."
        redirect_to lessons_path
      #elsif Rating.users_only_comment?(Lesson.find_by(id: params[:lesson_id]))
        #flash[:notice] = "Lesson not found."

      else
        @user = User.find_by(id: current_user)
        @rating = Rating.new(lesson_id: params[:lesson_id], user_id: @user.id)
      end
    else
      flash[:alert] = "You must log in to rate lessons"
      redirect_to(request.referrer || root_path)
    end
  end

  def create
    if logged_in?
      @rating = Rating.create(rating_params)
      authorize @rating
      flash[:notice] = "Rating Added"
      redirect_to rating_path(@rating)
    else
      flash[:alert] = "You must log in to rate lessons"
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
          @rating = lesson.ratings.find_by(id: params[:id])
        end
      @rating = Rating.find_by(id: params[:id])
      end
    else
      flash[:alert] = "You must log in to update ratings"
      redirect_to(request.referrer || root_path)
     end
  end

  def show
    @lesson = Lesson.find_by(id: params[:lesson_id])
    @user = User.find_by(id: params[:user_id])
    @rating = Rating.find_by(id: params[:id])
  end

  def update
    if logged_in?
      @rating = Rating.find_by(id: params[:id])
      authorize @rating
      @rating.update(rating_params)
      if @rating.save
        flash[:notice] = "Rating Updated"
        redirect_to rating_path(@rating)
      else
        render :edit
      end
    else
      flash[:alert] = "You must log in to update ratings"
      redirect_to(request.referrer || root_path)
    end
  end

  def destroy
    if logged_in?
      @rating = Rating.find(params[:id])
      authorize @rating
      @rating.destroy
      flash[:notice] = "Rating deleted."
      redirect_to lessons_path
    else
      flash[:alert] = "You must log in to delete ratings"
      redirect_to(request.referrer || root_path)
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:star_rating, :lesson_id, :user_id)
  end
end

