json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :title, :description, :references
  json.url lesson_url(lesson, format: :json)
end
