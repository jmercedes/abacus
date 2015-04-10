require 'rails_helper'

RSpec.describe "admin/requests/index", type: :view do
  before(:each) do
    assign(:admin_requests, [
      Admin::Request.create!(
        :amount => "Amount"
      ),
      Admin::Request.create!(
        :amount => "Amount"
      )
    ])
  end

  it "renders a list of admin/requests" do
    render
    assert_select "tr>td", :text => "Amount".to_s, :count => 2
  end
end
