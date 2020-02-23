class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :like, class_name: "Task"
end