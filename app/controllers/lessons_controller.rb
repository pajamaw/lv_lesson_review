class LessonsController < ApplicationController

  def index
    @first = Lesson.first.id - 1
    @lessons = Lesson.order(id: :asc).page(params[:page])
  end

  def show
    @lesson = Lesson.find(params[:id])
    @user = current_user
  end

  def hardest_lesson
    @lesson = Lesson.hardest_lesson
    render template: 'lessons/show'
  end
end
