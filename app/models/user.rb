class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :tasks
    has_many :relationships
    has_many :likings, through: :relationships, source: :like
    has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: "like_id"
    has_many :likeds, through: :relationships, source: :user
    
    def like(other_user)
        unless self == other_user
            self.relationships.find_or_create_by(like_id: other_user.id)
        end
    end
    
    def unlike
        relationship = self.relationships.find_by(like_id: other_user.id)
        relationship.destroy if relationship
    end
    
    def liking?(other_user)
        self.likings.include?(other_user)
    end
end
