class Admin::DashboardController < Admin::BaseController
require Rails.root + 'app/models/request.rb'

  def index
    @loans_count = Loan.count
    @total_lending = Loan.sum(:amount)
    @available_for_loans = Account.sum(:amount)
    @active_loans_count = Loan.approved_loans.count
    @requests_count = Request.count
    @total_interested_generated = 0
    @total_late_fee_amount = 0
    @loan_with_one_late_p = 0
    @loan_with_two_late_p = 0
    @loan_with_three_late_p = 0
    @total_payments_on_delay = 0
    @total_loans_with_delay_payments = 0
    Loan.find_each do |loan|
      @payments_on_delay = 0
      loan.amortization_calculation()[:periods].each do |period, value|
        if period <= Date.today
          @total_interested_generated +=value[:interest]
          @total_late_fee_amount += value[:late_fee]
          @payments_on_delay += value[:payments_on_delay]
        end
      end
      if @payments_on_delay > 0
        @total_loans_with_delay_payments += 1
        case @payments_on_delay
          when 1
            @loan_with_one_late_p += 1
          when 2
            @loan_with_two_late_p += 1
          when 3
            @loan_with_three_late_p += 1
        end
      end
      @total_payments_on_delay += @payments_on_delay
    end
  end
end
