require "./lib/options_capture"

module TranslationHelper
  def translate(key, locale: I18n.locale, **options, &block)
    block ||= proc do |value, full_key|
      translation = Translation.new(locale: locale, key: full_key, value: value, options: options)

      render translation
    end

    super key, locale: locale, **options, &block
  rescue I18n::MissingInterpolationArgument => error
    options[error.key] = "%{#{error.key}}"

    retry
  end

  def translate_interactive(key, attributes = {}, **options, &block)
    translate key, locale: locale, **options do |value, full_key|
      translation = Translation.new(locale: locale, key: full_key, value: value, options: options)

      builder = OptionsCapture.new(self)
      element = capture { block.call(builder, translation) }

      render("translations/interactive", translation: translation, builder: builder) { element }
    end
  end
end
