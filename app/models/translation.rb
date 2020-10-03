class Translation
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :locale, :string
  attribute :key, :string
  attribute :value, :string
  attribute :options, default: -> { {} }

  validate { errors.add(:key, :invalid) if new_record? }

  def id
    key
  end

  def value
    content = ActionText::Content.new(super)

    plain? ? content.to_plain_text : content.to_s
  end

  def template
    without_interpolations = attributes.merge(
      value: translate(key, locale: locale, **reserved_options),
      options: reserved_options
    )

    Translation.new(without_interpolations)
  end

  def interpolations
    interpolation_options.transform_values(&:to_s).reject { |key, value| "%{#{key}}" == value }
  end

  def new_record?
    translate(key, locale: locale, default: "").blank?
  end

  def save
    I18n.backend.store_translations(locale, { key => value })
  end

  def html?
    key.to_s.end_with?("html")
  end

  def plain?
    !html?
  end

  def to_key
    [key.gsub(".", "_")]
  end

  def to_s
    value
  end

  private

  delegate :translate, to: I18n

  def interpolation_options
    options.except *I18n::RESERVED_KEYS
  end

  def reserved_options
    options.slice *I18n::RESERVED_KEYS
  end
end
