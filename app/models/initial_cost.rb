# encoding: UTF-8
class InitialCost < ActiveRecord::Base
  attr_accessible :amount, :name, :loan_id

  NAMES = {
    notary: 'Costes Notariales',
    registry: 'Costes Registrales',
    assessment: 'Tasación',
    study: 'Comisión de estudio',
    activation: 'Comisión de activación'
  }

  belongs_to :loan

  validates :amount, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
