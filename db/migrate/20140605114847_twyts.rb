class Twyts < ActiveRecord::Migration
  def change
    create_table :twyts do |t|
      t.string :message, limit: 140
      t.timestamps
      t.belongs_to :user
    end
  end
end
