class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :subject_id
      t.string :description
      t.float :note
      t.float :weight

      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
