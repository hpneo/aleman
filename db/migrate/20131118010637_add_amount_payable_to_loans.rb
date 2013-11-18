class AddAmountPayableToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :amount_payable, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
