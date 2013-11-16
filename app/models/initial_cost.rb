class InitialCost < ActiveRecord::Base
  attr_accessible :amount, :name, :loan_id

  belongs_to :loan
end
