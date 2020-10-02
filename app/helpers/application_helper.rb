module ApplicationHelper
  def editable
    Editable.new(self)
  end

  class Editable
    def initialize(template)
      @template = template
    end

    def translate(key, locale: I18n.locale, **options)
      @template.translate key, **options do |value, full_key|
        translation = Translation.new(locale: locale, key: full_key, value: value)

        @template.render translation
      end
    end
  end
  private_constant :Editable
end
