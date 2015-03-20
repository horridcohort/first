class Vote < ActiveRecord::Base
    belongs_to :dare
validates_uniqueness_of :user_id, scope: :dare_id
validates_presence_of :dare_id
validates_inclusion_of :value, in: [1, -1]
def user
	User.where("user_id = ?", id)
end
end