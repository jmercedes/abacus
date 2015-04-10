require 'rails_helper'

RSpec.describe "admin/requests/edit", type: :view do
  before(:each) do
    @admin_request = assign(:admin_request, Admin::Request.create!(
      :amount => "MyString"
    ))
  end

  it "renders the edit admin_request form" do
    render

    assert_select "form[action=?][method=?]", admin_request_path(@admin_request), "post" do

      assert_select "input#admin_request_amount[name=?]", "admin_request[amount]"
    end
  end
end
