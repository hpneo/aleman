class LoansController < InheritedResources::Base
  before_filter :authenticate_user!

  before_filter :set_owner, only: [:create, :update]

  def index
    @loans = current_user.loans
    
    index!
  end

  def new
    @loan = Loan.new

    5.times { @loan.initial_costs.build }
    5.times { @loan.recurrent_costs.build }

    new!
  end

  private

  def set_owner
    params[:loan][:user_id] = current_user.id
  end
end
