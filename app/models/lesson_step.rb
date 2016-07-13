class LessonStep < ActiveRecord::Base
  mount_uploader :photo, StepPhotoUploader

  belongs_to :lesson
end
