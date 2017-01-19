class Review < ApplicationRecord
  validates :rating, inclusion: (1..5)
  validates :thoughts,
             :presence => true,
             :length => { :minimum => 3, :message => "Must be at least 3 characters"}
  belongs_to :restaurant
  belongs_to :user
  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }
  has_many :endorsements 
end
