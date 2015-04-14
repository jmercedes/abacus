class Admin::DashboardController < Admin::BaseController
  def index
    @loans_count = Loan.count
  end
end
