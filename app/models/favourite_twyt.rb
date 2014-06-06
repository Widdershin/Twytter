class FavouriteTwyt < ActiveRecord::Base
  belongs_to :user
  belongs_to :twyt
end
