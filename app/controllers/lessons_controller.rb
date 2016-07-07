class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find(params[:id])
    @lesson_steps = @lesson.steps
    @user = current_user
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        #key: "pk_test_z3971ulOJS1heFJXHUYprE5Z",
        description: "Lesson Land - #{@lesson.name}",
        amount: (@lesson.price*100).round, #Amount.default
        label: "Purchase for #{ActiveSupport::NumberHelper.number_to_currency(@lesson.price)}"
      }
  end

  def index
    @lessons = Lesson.all
  end
end
