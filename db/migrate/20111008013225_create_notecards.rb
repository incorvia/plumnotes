class CreateNotecards < ActiveRecord::Migration
  def change
    create_table :notecards do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end

    add_index :notecards, :user_id

  end
end
