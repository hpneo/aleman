class RenameInflationRateToAnnualInflationRate < ActiveRecord::Migration
  def up
    rename_column :loans, :inflation_rate, :annual_inflation_rate
    rename_column :payments, :inflation_rate, :annual_inflation_rate
  end

  def down
  end
end
