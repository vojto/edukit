class AddReferencesToUser < ActiveRecord::Migration
  def self.up
    add_column :subjects, :user_id, :integer
    
    create_table :exams do |t|
      t.column :when, :date           # date when exam takes place
      t.column :subject_id, :integer  # subject
      t.column :notes, :text          # user notes
      t.column :length, :integer      # how long will it take to prepare
      t.column :length_done, :integer # how much we already know
    end
    
    create_table :homeworks do |t|
      t.column :when, :date
      t.column :subject_id, :integer
      t.column :notes, :text
      t.column :length, :integer
      t.column :length_done, :integer
    end
    
    create_table :lesson_prepares do |t|
      t.column :subject_lesson_id, :integer # lesson (the one we are preparing for)
      t.column :length_done, :integer       # how much we already know
    end
  end

  def self.down
  end
end
