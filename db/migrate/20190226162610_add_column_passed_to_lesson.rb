class AddColumnPassedToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :passed, :boolean, :default => false
  end
end
