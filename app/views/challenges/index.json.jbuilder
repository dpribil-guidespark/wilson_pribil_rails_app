json.array!(@challenges) do |challenge|
  json.extract! challenge, :id, :question, :hint, :answer
  json.url challenge_url(challenge, format: :json)
end
