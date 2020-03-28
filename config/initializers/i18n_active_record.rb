Rails.application.config.after_initialize do
  require "i18n/backend/active_record"

  I18n::Backend::ActiveRecord.include(I18n::Backend::Memoize)

  I18n.backend = I18n::Backend::Chain.new(
    I18n::Backend::ActiveRecord.new,
    I18n.backend,
  )
end