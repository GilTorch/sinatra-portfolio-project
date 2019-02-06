class AddColumnPassedToChapters < ActiveRecord::Migration[5.2]
    def change
      add_column :chapters,:passed,:boolean,default: false
    end
  end
  