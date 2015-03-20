class LogicalFixInLessonPrepares < ActiveRecord::Migration
  def self.up
    remove_column :lesson_prepares, :subject_lesson_id
    add_column :lesson_prepares, :subject_id, :integer
  end

  def self.down
  end
end
