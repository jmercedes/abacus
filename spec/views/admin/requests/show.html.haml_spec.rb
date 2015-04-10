require 'rails_helper'

RSpec.describe "admin/requests/show", type: :view do
  before(:each) do
    @admin_request = assign(:admin_request, Admin::Request.create!(
      :amount => "Amount"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Amount/)
  end
end
