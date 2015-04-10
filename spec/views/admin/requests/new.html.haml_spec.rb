require 'rails_helper'

RSpec.describe "admin/requests/new", type: :view do
  before(:each) do
    assign(:admin_request, Admin::Request.new(
      :amount => "MyString"
    ))
  end

  it "renders new admin_request form" do
    render

    assert_select "form[action=?][method=?]", admin_requests_path, "post" do

      assert_select "input#admin_request_amount[name=?]", "admin_request[amount]"
    end
  end
end
