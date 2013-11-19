class LoansController < InheritedResources::Base
  before_filter :authenticate_user!

  def index
    @loans = current_user.loans
    
    index!
  end
end
