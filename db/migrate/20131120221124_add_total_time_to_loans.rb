class AddTotalTimeToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :total_time, :integer
    add_column :loans, :total_time_type, :integer
  end
end
