json.array!(@auditorias) do |auditoria|
  json.extract! auditoria, :id, :user_id, :questao_id
  json.url auditoria_url(auditoria, format: :json)
end
