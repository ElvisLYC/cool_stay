class AddRoleColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, ault: 0
  end
end
