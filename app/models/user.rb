class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
           has_many :favorites,dependent: :destroy
           attachment :profile_image
           has_many :books, dependent: :destroy
           has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id',dependent: :destroy
           has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id',dependent: :destroy
           has_many :followers, through: :followed, source: :follower
           has_many :followings, through: :follower, source: :followed
        def follow(other_user)
            unless self == other_user
            self.follower.find_or_create_by(followed_id: other_user.id)
            end
        end

        def unfollow(other_user)
            follower = self.follower.find_by(followed_id: other_user.id)
            follower.destroy if follower
        end

        def following?(other_user)
            followings.include?(other_user)
        end
            validates :name, presence: true
            validates :name, length: { minimum: 2 }
            validates :name, length: { maximum: 20 }
            validates :introduction, length: { maximum: 50 }
            validates :name, uniqueness: true
end


