class Payment < ActiveRecord::Base
  attr_accessible :amortization, :annual_inflation_rate, :annual_interest_rate, :cash_flow, :final_balance
  attr_accessible :grace_period_type, :interest, :opening_balance, :payment_index, :periodic_inflation_rate
  attr_accessible :periodic_interest_rate, :prepayment, :quota, :start_at, :d_id

  belongs_to :loan

  before_create :set_up_attributes

  def is_first_payment?
    self.payment_index == 1
  end

  def previous_payment_final_balance
    unless self.is_first_payment?
      Payment.where(loan_id: self.loan_id, payment_index: self.payment_index - 1).select(:final_balance).first.final_balance
    else
      0.0
    end
  end

  def indexed_opening_balance
    self.opening_balance * (1 + self.periodic_inflation_rate)
  end

  def credit_life_insurance_percentage
    (self.loan.credit_life_insurance_percentage * self.loan.frequency) / 30
  end

  def credit_life_insurance
    -self.indexed_opening_balance * self.credit_life_insurance_percentage
  end

  def cash_flow_credit_life_insurance
    if self.grace_period_type == 's'
      0.0
    else
      self.credit_life_insurance
    end
  end

  def risk_insurance
    (-self.loan.risk_insurance_percentage * self.loan.sale_price) / self.loan.payments_per_year
  end

  def periodic_fee
    -self.loan.periodic_fee
  end

  def freight
    -self.loan.freight
  end

  def administrative_costs
    -self.loan.administrative_costs
  end

  def set_up_attributes
    self.periodic_interest_rate = ((self.annual_interest_rate + 1) ** (self.loan.frequency.to_f / Loan::DAYS_PER_YEAR)) - 1
    self.periodic_inflation_rate = ((self.annual_inflation_rate + 1) ** (self.loan.frequency.to_f / Loan::DAYS_PER_YEAR)) - 1

    if self.is_first_payment?
      self.opening_balance = self.loan.amount_payable
    else
      self.previous_payment_final_balance
    end

    self.interest = -self.indexed_opening_balance * self.periodic_interest_rate

    case self.grace_period_type
    when 't'
      self.amortization = 0
      self.quota = 0
      self.final_balance = self.indexed_opening_balance - self.interest
    when 'p'
      self.amortization = 0
      self.quota = self.interest
      self.final_balance = self.indexed_opening_balance + self.amortization + self.prepayment
    when 's'
      self.amortization = -self.indexed_opening_balance / (self.loan.payments_count - self.payment_index + 1)
      self.quota = self.interest + self.amortization + self.credit_life_insurance
      self.final_balance = self.indexed_opening_balance + self.amortization + self.prepayment
    end

    self.cash_flow = self.quota + self.prepayment + self.risk_insurance + self.periodic_fee + self.freight + self.administrative_costs + self.cash_flow_credit_life_insurance
  end
end
