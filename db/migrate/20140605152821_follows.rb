class Follows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :origin
      t.references :target
      t.timestamps
    end
  end
end
