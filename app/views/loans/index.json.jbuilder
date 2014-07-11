json.array!(@loans) do |loan|
  json.extract! loan, :id, :amount
  json.url loan_url(loan, format: :json)
end
