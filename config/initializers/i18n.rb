ActiveSupport.on_load :i18n do
  require "i18n/postgres_json/backend"

  I18n.backend = I18n::Backend::Chain.new(
    I18n::PostgresJson::Backend.new,
    I18n.backend,
  )
end
