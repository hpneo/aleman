class CreateRecurrentCosts < ActiveRecord::Migration
  def change
    create_table :recurrent_costs do |t|
      t.references :loan
      t.string :name
      t.decimal :amount, precision: 14, scale: 7, default: 0.0

      t.timestamps
    end
  end
end
