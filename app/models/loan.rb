# encoding: UTF-8
class Loan < ActiveRecord::Base
  attr_accessible :amount_payable, :annual_inflation_rate, :annual_interest_rate, :discount_rate, :frequency
  attr_accessible :grace_period_type, :initial_payment, :payments_count, :sale_price, :start_at, :total_days, :user_id
  attr_accessible :total_time, :total_time_type, :initial_costs_attributes, :recurrent_costs_attributes

  TIME_TYPES = {
    15 => 'Quincenas',
    30 => 'Meses',
    180 => 'Semestres',
    360 => 'Años'
  }

  FREQUENCIES = {
    15 => 'Quincenal',
    30 => 'Mensual',
    180 => 'Semestral',
    360 => 'Anual'
  }

  GRACE_PERIODS = {
    s: 'Sin plazo',
    t: 'Plazo total',
    p: 'Plazo parcial'
  }

  DAYS_PER_YEAR = 360

  belongs_to :user
  has_many :payments
  has_many :initial_costs
  has_many :recurrent_costs

  accepts_nested_attributes_for :initial_costs
  accepts_nested_attributes_for :recurrent_costs

  before_update :set_up_attributes
  after_update :set_up_payments

  def set_up_attributes
    self.total_days = self.total_time * self.total_time_type
    self.amount_payable = self.sale_price - self.initial_payment + self.total_initial_costs
  end

  def payments_count
    self.payments_per_year * self.years_count
  end

  def set_up_payments
    self.payments.destroy_all

    1.upto(self.payments_count) do |i|
      self.payments.create({
        payment_index: i,
        annual_interest_rate: self.annual_interest_rate,
        annual_inflation_rate: self.annual_inflation_rate,
        grace_period_type: self.grace_period_type
      })
    end
  end

  def payments_per_year
    (DAYS_PER_YEAR / self.frequency).to_i
  end

  def years_count
    self.total_days / DAYS_PER_YEAR
  end

  def total_initial_costs
    self.initial_costs.pluck(:amount).sum
  end

  def credit_life_insurance_percentage
    self.recurrent_costs.where(name: 'credit_life_insurance_percentage').pluck(:amount).sum.to_f
  end

  def risk_insurance_percentage
    self.recurrent_costs.where(name: 'risk_insurance_percentage').pluck(:amount).sum.to_f
  end

  def periodic_fee
    self.recurrent_costs.where(name: 'periodic_fee').pluck(:amount).sum.to_f
  end

  def freight
    self.recurrent_costs.where(name: 'freight').pluck(:amount).sum.to_f
  end

  def administrative_costs
    self.recurrent_costs.where(name: 'administrative_costs').pluck(:amount).sum.to_f
  end
end
