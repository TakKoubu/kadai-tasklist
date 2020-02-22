class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :favorite, class_name: "User"
end
