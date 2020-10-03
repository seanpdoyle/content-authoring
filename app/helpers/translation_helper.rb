module TranslationHelper
  def translate(*arguments, locale: I18n.locale, **options)
    super *arguments, **options do |value, key|
      translation = Translation.new(locale: locale, key: key, value: value, options: options)

      render translation
    end
  rescue I18n::MissingInterpolationArgument => error
    options[error.key] = "%{#{error.key}}"

    retry
  end
end
