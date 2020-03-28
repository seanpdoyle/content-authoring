class Translation < I18n::Backend::ActiveRecord::Translation
  after_save do
    I18n.backend.backends.each(&:reload!)
  end
end
