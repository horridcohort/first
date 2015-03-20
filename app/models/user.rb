class User < ActiveRecord::Base
 # attr_accessor :remember_token
 scope :top_points, -> { joins(:points).where('user_id = user_id').order('points_count DESC') }
 scope :top_won, -> { joins(:dares).group('user_id = dares.won_id').order('count(dares.won_id) desc') }
  after_save :points_add
  before_validation :normalize_name, on: :create
  has_many :comments, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  has_many :points, dependent: :destroy
  User.includes(:points)
  User.includes(:posts)
  User.includes(:dares)
     has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
   has_many :dares, dependent: :destroy
  has_many :sent_dares, class_name: 'Dare',
                                     dependent: :destroy
  has_many :received_dares, -> {order('created_at DESC')}, class_name: 'Dare',
                                     dependent: :destroy
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 6 }, allow_blank: true
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("name like ?", "%#{query}%") 
  end
       # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
    # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
   def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end
  def comment_feed
    Comment.where("post_id = ?", id)
  end
   def sent_feed
    Dare.where("sender_id = ?", id)
end
   def dare_feed
    Dare.where("recipient_id = ?", id)
end
def won_feed
  Dare.where("won_id = ?", id)
  end
  def lost_feed
  Dare.where("lost_id = ?", id)
  end
    def issued_feed
  Dare.where("issued_id = ?", id)
  end
def point
    Point.where("user_id = ?", id) 
end
def dare
  Dare.where("user_id = ?", id)
  end
  def upvote
 vote = Vote.where('dare_id = ?', id)
 vote.where('value = 1' , id)
  end
def downvote
 vote = Vote.where('dare_id = ?', id)
 vote.where('value = -1' , id)
  end
  def post
    Post.where("user_id = ?", id)
  end
  def won
  Dare.where("dares.won_id = ?", id)
  end
def position
  User.connection.select_value("SELECT COUNT(*)+1 AS position FROM users "+
    "WHERE points_count > "+
      "(SELECT points_count FROM users WHERE id = #{self.id})").to_i
end
  def lost
   Dare.where('lost_id = ?', id)    
  end
  def winners
   User.joins(:dares).group('won_id = user_id', id)
  end
    def issued
  Dare.where("dares.issued_id = ?", id)    
  end
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end
  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
  def user_points
    user = User.where('user_id = ?', id)
  user.joins(:points).group("points.count")
end
def validate()
  unless bet.to_s =~ /^[+]?\d+$/
    errors.add("foo", "is not a valid number")
  end
end
def can_vote_for?(dare)
  user = User.where('user_id = ?', id)
  Vote.where('dare_id = ?', id)
end
def
def reduce_points
     user = read_attribute(:lost_id)
     bet = read_attribute(:bet)
     points = user.points.first(bet)
     
      points.each do |f|
      f.destroy
    end
      end
private
def normalize_name
      self.name = self.name.downcase.titleize
    end
  def points_add
   bet = read_attribute(:bet)
  bet.times do |point|
    self.points.create!
  end
end
end