module TranslationHelper
  def translate(*)
    super do |value, key|
      translation = Translation.new(locale: I18n.locale, key: key, value: value)

      render translation
    end
  end
end
