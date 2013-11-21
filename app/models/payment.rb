class Payment < ActiveRecord::Base
  attr_accessible :amortization, :annual_inflation_rate, :annual_interest_rate, :cash_flow, :final_balance
  attr_accessible :grace_period_type, :interest, :opening_balance, :payment_index, :periodic_inflation_rate
  attr_accessible :periodic_interest_rate, :prepayment, :quota, :start_at, :loan_id

  belongs_to :loan

  validates :annual_interest_rate, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :periodic_interest_rate, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :annual_inflation_rate, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :periodic_inflation_rate, numericality: { greater_than_or_equal_to: 0 }, presence: true

  before_save :set_up_attributes
  after_save :update_next_payment

  def is_first_payment?
    self.payment_index == 1
  end

  def is_last_payment?
    self.payment_index == self.loan.payments_count
  end

  def previous_payment
    unless self.is_first_payment?
      Payment.where(loan_id: self.loan_id, payment_index: self.payment_index - 1).first
    end
  end

  def next_payment
    unless self.is_last_payment?
      Payment.where(loan_id: self.loan_id, payment_index: self.payment_index + 1).first
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
    -((self.loan.risk_insurance_percentage * self.loan.sale_price) / self.loan.payments_per_year)
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
    self.periodic_interest_rate = ((self.annual_interest_rate + 1) ** (self.loan.frequency.to_d / loan.days_per_year)) - 1
    self.periodic_inflation_rate = ((self.annual_inflation_rate + 1) ** (self.loan.frequency.to_d / loan.days_per_year)) - 1

    if self.is_first_payment?
      self.opening_balance = self.loan.amount_payable
    else
      self.opening_balance = self.previous_payment.final_balance
    end

    self.interest = -self.indexed_opening_balance * self.periodic_interest_rate
    self.start_at = self.loan.start_at + (self.payment_index * self.loan.frequency).days

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

    self
  end

  def update_next_payment
    if is_last_payment?
      self.loan.update_column(:irr, self.loan.calculate_irr)
      self.loan.update_column(:npv, self.loan.calculate_npv)
    end

    if self.next_payment
      self.next_payment.set_up_attributes.save
    end
  end
end
