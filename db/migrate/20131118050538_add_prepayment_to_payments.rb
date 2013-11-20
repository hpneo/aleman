class AddPrepaymentToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :prepayment, :decimal, precision: 14, scale: 7, default: 0.0
  end
end
