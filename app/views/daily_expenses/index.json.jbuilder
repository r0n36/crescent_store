json.array!(@daily_expenses) do |daily_expense|
  json.extract! daily_expense, :id
  json.url daily_expense_url(daily_expense, format: :json)
end
