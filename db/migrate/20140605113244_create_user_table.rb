class CreateUserTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_hash
      t.string :email

      t.timestamps
    end
  end
end
