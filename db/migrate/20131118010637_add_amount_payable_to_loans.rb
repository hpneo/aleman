class AddAmountPayableToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :amount_payable, :decimal, precision: 12, scale: 4, default: 0.0
  end
end
