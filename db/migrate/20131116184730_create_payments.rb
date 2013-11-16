class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :loan
      t.integer :payment_index
      t.date :start_at
      t.decimal :annual_interest_rate, precision: 10, scale: 2, default: 0.0
      t.decimal :periodic_interest_rate, precision: 10, scale: 2, default: 0.0
      t.decimal :inflation_rate, precision: 10, scale: 2, default: 0.0
      t.decimal :periodic_inflation_rate, precision: 10, scale: 2, default: 0.0
      t.string :grace_period_type
      t.decimal :opening_balance, precision: 10, scale: 2, default: 0.0
      t.decimal :interest, precision: 10, scale: 2, default: 0.0
      t.decimal :amortization, precision: 10, scale: 2, default: 0.0
      t.decimal :quota, precision: 10, scale: 2, default: 0.0
      t.decimal :final_balance, precision: 10, scale: 2, default: 0.0
      t.decimal :cash_flow, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
