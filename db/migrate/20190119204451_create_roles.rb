class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :role_label 
      t.string :user_id 
      t.string :permission
    end
  end
end
