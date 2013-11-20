class RemovePaymentsCountFromLoans < ActiveRecord::Migration
  def up
    remove_column :loans, :payments_count
  end

  def down
    add_column :loans, :payments_count, :integer, default: 0
  end
end
