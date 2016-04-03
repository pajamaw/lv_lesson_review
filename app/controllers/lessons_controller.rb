class LessonsController < ApplicationController

  def index
    @first = Lesson.first.id - 1
    @lessons = Lesson.order(id: :asc).page(params[:page])
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  def hardest_lesson
    @lesson = Lesson.hardest_lesson
    render template: 'lessons/show'
  end
end
