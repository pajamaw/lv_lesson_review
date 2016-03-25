class LessonsController < ApplicationController

  def index
    @lessons = Lesson.all
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  def hardest_lesson
    @lesson = Lesson.hardest_lesson
    render template: 'lessons/show'
  end
end
