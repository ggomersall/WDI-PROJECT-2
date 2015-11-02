json.array!(@addresses) do |address|
  json.extract! address, :id, :telephone, :address_line_1, :address_line_2, :city, :county, :post_code, :country, :delivery_notes, :company_name, :user_id
  json.url address_url(address, format: :json)
end
