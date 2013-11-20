class AddAmountPayableToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :amount_payable, :decimal, precision: 14, scale: 7, default: 0.0
  end
end
