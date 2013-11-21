class AddNpvToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :npv, :decimal, precision: 14, scale: 7, default: 0.0
  end
end
