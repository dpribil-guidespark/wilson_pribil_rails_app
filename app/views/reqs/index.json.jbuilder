json.array!(@reqs) do |req|
  json.extract! req, :id, :title, :department, :manager, :description
  json.url req_url(req, format: :json)
end
