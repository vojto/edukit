class AddColumnsToSubjects < ActiveRecord::Migration
  def self.up
    add_column :subjects, :time, :integer
    add_column :subjects, :type, :string
  end

  def self.down
    remove_column :subjects, :time
    remove_column :subjects, :type
  end
end
