class Translation < I18n::Backend::ActiveRecord::Translation
  class RichText < ActionText::Content
    def body
      self
    end
  end

  after_save do
    I18n.backend.backends.each(&:reload!)
  end

  def rich_text?
    key.ends_with?(".html") || key.ends_with?("_html")
  end

  def value
    if rich_text?
      RichText.new(super)
    else
      super
    end
  end
end
