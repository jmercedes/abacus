require 'rails_helper'

<<<<<<< HEAD
RSpec.describe "requests/index.html.haml", type: :view do
  pending "add some examples to (or delete) #{__FILE__}"
=======
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
>>>>>>> 91b359d85a3b3bf11746564d18b8a9e739b9780c
end
