class CreateAssociations < ActiveRecord::Migration
  def change
    create_table :associations do |t|
      t.integer :notecard_id
      t.integer :tag_id

      t.timestamps
    end

    add_index :associations, :notecard_id
    add_index :associations, :tag_id

  end
end
