class Lesson < ActiveRecord::Base
  belongs_to :categories
  has_many :lesson_steps
end
