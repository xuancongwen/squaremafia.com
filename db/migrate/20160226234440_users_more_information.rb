class UsersMoreInformation < ActiveRecord::Migration
  def change
    add_column :users, :sq_start_date, :date
    add_column :users, :sq_end_date, :date
    add_column :users, :discipline, :string
  end
end
