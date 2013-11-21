class PaymentSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper
  include LoansHelper
  attributes :amortization, :annual_inflation_rate, :annual_interest_rate, :cash_flow, :final_balance
  attributes :grace_period_type, :interest, :opening_balance, :payment_index, :periodic_inflation_rate
  attributes :periodic_interest_rate, :prepayment, :quota, :start_at, :loan_id, :id

  def start_at
    object.start_at.to_s
  end

  def annual_interest_rate
    number_to_percentage(object.annual_interest_rate * 100, significant: true)
  end

  def periodic_interest_rate
    number_to_percentage(object.periodic_interest_rate * 100, significant: true)
  end

  def annual_inflation_rate
    number_to_percentage(object.annual_inflation_rate * 100, significant: true)
  end

  def periodic_inflation_rate
    number_to_percentage(object.periodic_inflation_rate * 100, significant: true)
  end

  def grace_period_type
    Loan::GRACE_PERIODS[object.grace_period_type.to_sym]
  end

  def opening_balance
    conditional_format(number_to_currency(object.opening_balance))
  end

  def interest
    conditional_format(number_to_currency(object.interest))
  end

  def amortization
    conditional_format(number_to_currency(object.amortization))
  end

  def quota
    conditional_format(number_to_currency(object.quota))
  end

  def final_balance
    conditional_format(number_to_currency(object.final_balance))
  end

  def cash_flow
    conditional_format(number_to_currency(object.cash_flow))
  end
end
