class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.references :user
      t.decimal :sale_price, precision: 12, scale: 4, default: 0.0
      t.decimal :initial_payment, precision: 12, scale: 4, default: 0.0
      t.date :start_at
      t.integer :frequency
      t.string :grace_period_type
      t.integer :total_days
      t.integer :payments_count
      t.decimal :annual_interest_rate, precision: 12, scale: 4, default: 0.0
      t.decimal :inflation_rate, precision: 12, scale: 4, default: 0.0
      t.decimal :discount_rate, precision: 12, scale: 4, default: 0.0

      t.timestamps
    end
  end
end
