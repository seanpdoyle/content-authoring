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

  def value=(value)
    if value.is_a?(Hash)
      self.value = value.reduce([]) do |array, (index, value)|
        array[index.to_i] = value
        array
      end
    else
      super
    end
  end

  def value
    if rich_text?
      RichText.new(super)
    else
      super
    end
  end
end
