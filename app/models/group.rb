class Group < ActiveRecord::Base
  belongs_to :key_term, class_name: "Term"

  validates_presence_of :key_term
end
