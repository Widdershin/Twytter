class Twyts < ActiveRecord::Migration
  def change
    create_table :twyts do |t|
      t.string :message, limit: 140
      t.integer :owner
      t.timestamps
    end
  end
end
