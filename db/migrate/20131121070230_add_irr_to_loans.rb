class AddIrrToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :irr, :decimal, precision: 14, scale: 7, default: 0.0
  end
end
