class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: { case_sensitive: false }
    has_secure_password
    has_many :tasks
    
    has_many :relationships
    has_many :likes, through: :relationships, source: :like
    has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: "like_id"
    has_many :subjects, through: :reverses_of_relationship, source: :user
    
    def like(other_task)
        unless self == other_task
            self.relationships.find_or_create_by(like_id: other_task.id)
        end
    end
    
    def unlike(other_task)
        relationship = self.relationships.find_by(like_id: other_task.id)
        relationship.destroy if relationship
    end
    
    def liking?(other_task)
        self.likes.include?(other_task)
    end    
    
    def feed_tasks
        Task.where(id: self.like_ids)
    end
    
    def feed_tasks_everyone
        Task.where(id: self.like_ids)
    end
end
