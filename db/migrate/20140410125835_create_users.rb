class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :token
      t.string :system_id
      t.timestamps
    end

    add_index :users, :token
    add_index :users, :system_id
  end
end
