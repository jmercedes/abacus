class Admin::DashboardController < Admin::BaseController
  def index
    @loans_count = Loan.count
    @total_lending = Loan.sum(:amount)
    @available_for_loans = Account.sum(:amount)
  end
end
