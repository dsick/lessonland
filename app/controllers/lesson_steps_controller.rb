class LessonStepsController < ApplicationController
  def show
    @lesson_step = LessonStep.find(params[:id])
  end
end
