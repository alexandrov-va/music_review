json.extract! music, :id, :title, :description, :release_year, :artist, :created_at, :updated_at
json.url music_url(music, format: :json)
