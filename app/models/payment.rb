class Payment < ActiveRecord::Base
  attr_accessible :amortization, :annual_interest_rate, :cash_flow, :final_balance, :grace_period_type, :inflation_rate, :interest, :opening_balance, :payment_index, :periodic_inflation_rate, :periodic_interest_rate, :quota, :start_at, :loan_id

  belongs_to :loan
end
