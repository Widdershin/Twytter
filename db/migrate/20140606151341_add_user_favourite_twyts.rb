class AddUserFavouriteTwyts < ActiveRecord::Migration
  def change
    create_table :favourite_twyts do |t|
      t.belongs_to :user
      t.belongs_to :twyt
    end
  end
end
