class RatingsController < ApplicationController
  def create
    @user = User.find_by(id: current_user)
    @lesson = Lesson.find_by(id: params[:lesson_id])
    @rating= Rating.create(user_id: @user.id, ratable_type: 'Lesson', ratable_id: params[:lesson_id], star_rating: params[:star_rating])
    flash[:notice] = "Rating Added"
    redirect_to lesson_path(@lesson)
  end
end
