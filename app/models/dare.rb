class Dare < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  has_one :video
  Dare.includes(:video)
  Dare.includes(:votes)
  has_many :down_votes, -> { where "value = -1" }
  has_many :up_votes, -> { where "value = 1" }
  belongs_to :recipient, foreign_key: 'recipient_id', class_name: 'User'
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User'
  default_scope -> {order(created_at: :desc) }
  validates :bet, :numericality => { :greater_than_or_equal_to => 0 }, presence: true, numericality: { only_integer: true }
  validates :body, presence: true
  def self.by_votes
  select('dares.*, coalesce(value, 0) as votes').
  joins('left join dare_votes on dare_id=dares.id').
  order('votes desc')
end
def votes
  read_attribute(:votes) #|| dare_votes.sum(:value)
end
def upvote
 vote = Vote.where('dare_id = ?', id)
 vote.where('value = 1' , id)
  end
def downvote
 vote = Vote.where('dare_id = ?', id)
 vote.where('value = -1' , id)
  end
  def points_add(dare)
   bet = read_attribute(:bet)
   user = read_attribute(:won_id)
  bet.times do |point|
    Point.create!(:user_id => user)
  end
end
    def add_points
      user = self.sender_id
     bet = self.bet
     bet.times do |f|
      Point.create(:user_id => user)
    end
      end
def loser
  user = User.where('user_id = lost_id')
  this.user
end
def winner
   user = User.where('user_id = won_id')
  this.user
  end
def reduce_points(dare)
     points = self.user.points.first(self.bet)
      points.each do |f|
     f.destroy
    end
      end
  def update
if   self.upvote.count >= self.downvote.count
user = self.recipient_id
    loser = self.sender_id
    self.update_attributes!(:won_id => self.recipient_id, :lost_id => self.sender_id, :issued_id => self.user_id)
    points_add(self)
    reduce_points(self)
  else
    user = self.sender_id
    loser = self.recipient
    bet = self.bet
    self.update_attributes!(:won_id => self.sender_id, :lost_id => self.recipient_id, :issued_id => self.user_id)
   points = loser.points.first(bet)
      points.each do |f|
     f.destroy
   end
     bet.times do |f|
      Point.create(:user_id => user)
    end
end   
end
handle_asynchronously :update, :run_at => Proc.new { 1440.minutes.from_now }
    def link

    user = self.sender_id
    loser = self.recipient
    bet = self.bet
    self.update_attributes!(:won_id => self.sender_id, :lost_id => self.recipient_id, :issued_id => self.user_id)
    reduce_points(self)
    points_add(self)
    end
    def accept
      update_column :accepted, true
    end
end
