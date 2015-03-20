class AddDateColumnToLessonPrepares < ActiveRecord::Migration
  def self.up
    add_column :lesson_prepares, :date, :date
  end

  def self.down
  end
end
