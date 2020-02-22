class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: { case_sensitive: false }
    has_secure_password
    has_many :tasks
    has_many :relationships
    has_many :favoritings, through: :relationships, source: :favorite
    has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: "favorite_id"
    has_many :favoriteds, through: :relationships, source: :user
end
