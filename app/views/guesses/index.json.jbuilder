json.array!(@guesses) do |guess|
  json.extract! guess, :id, :answer, :status
  json.url guess_url(guess, format: :json)
end
