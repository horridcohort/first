class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
	default_scope -> {order(created_at: :desc) }
    validates :post_id, presence: true
	validates_presence_of :content
	validates :user_id, presence: true
	validates :name, presence: true
end
