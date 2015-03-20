class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  belongs_to :user, :counter_cache => true
 # validate :user_quota, :on => :create
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
  Post.includes(:comments)
#  after_save :add_points
 def comment_feed
    Comment.where("post_id = ?", id)
  end
  def post
  	Post.where("post_id = ?", id)
  end
  def point
    Point.where("user_id = ?", id) 
end
def normalize_name
      self.name = self.name.downcase.titleize
    end
end