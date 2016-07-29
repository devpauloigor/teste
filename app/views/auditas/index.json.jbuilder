json.array!(@auditas) do |audita|
  json.extract! audita, :id, :user_id, :questao_id
  json.url audita_url(audita, format: :json)
end
