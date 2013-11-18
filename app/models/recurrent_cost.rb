# encoding: UTF-8
class RecurrentCost < ActiveRecord::Base
  attr_accessible :amount, :name, :loan_id

  NAMES = {
    periodic_fee: 'Comisión periódica',
    freight: 'Portes',
    administrative_costs: 'Gastos administrativos',
    credit_life_insurance_percentage: 'Porcentaje de seguro de desgravamen',
    risk_insurance_percentage: 'Porcentaje de seguro de riesgo'
  }

  belongs_to :loan
end
