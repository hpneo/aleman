class Loan < ActiveRecord::Base
  attr_accessible :amount_payable, :annual_interest_rate, :discount_rate, :frequency, :grace_period_type, :inflation_rate, :initial_payment, :payments_count, :sale_price, :start_at, :total_days, :user_id

  belongs_to :user
end
