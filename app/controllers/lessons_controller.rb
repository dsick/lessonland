class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find(params[:id])
    @lesson_steps = @lesson.steps
  end

  def index
    @lessons = Lesson.all
  end
end
