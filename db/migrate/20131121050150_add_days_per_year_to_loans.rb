class AddDaysPerYearToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :days_per_year, :integer, default: 360
  end
end
