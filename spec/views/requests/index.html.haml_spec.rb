require 'rails_helper'

RSpec.describe "requests/index", type: :view do
  before(:each) do
    assign(:requests, [
      Request.create!(
        :amount => "9.99"
      ),
      Request.create!(
        :amount => "9.99"
      )
    ])
  end

  it "renders a list of requests" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
