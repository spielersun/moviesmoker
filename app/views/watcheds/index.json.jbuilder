json.array!(@watcheds) do |watched|
  json.extract! watched, :id, :movie_id, :user_id, :add_date
  json.url watched_url(watched, format: :json)
end
