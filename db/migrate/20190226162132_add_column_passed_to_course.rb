class AddColumnPassedToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :passed, :boolean, :default => false
  end
end
