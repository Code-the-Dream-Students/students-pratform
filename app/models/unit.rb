class Unit < ApplicationRecord
  has_many :course_units
  has_many :courses, through: :course_units
  has_many :unit_lessons
  has_many :lessons, through: :unit_lessons
  has_many :weeks

  validates_presence_of :unit_name, :description, :on => :create

  validates_length_of :unit_name, :description,
    :minimum => 2,
    :allow_nil => true

end
