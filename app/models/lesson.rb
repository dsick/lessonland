class Lesson < ActiveRecord::Base
  belongs_to :category
  has_many :lesson_steps

  accepts_nested_attributes_for :category
end
