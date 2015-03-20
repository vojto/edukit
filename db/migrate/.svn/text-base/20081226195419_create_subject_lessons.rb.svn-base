class CreateSubjectLessons < ActiveRecord::Migration
  def self.up
    create_table :subject_lessons do |t|
      t.integer :day
      t.integer :lesson

      t.timestamps
    end
  end

  def self.down
    drop_table :subject_lessons
  end
end
