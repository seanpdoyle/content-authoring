class Translation
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :locale, :string
  attribute :key, :string
  attribute :value, :string

  validate { errors.add(:key, :invalid) if new_record? }

  def id
    key
  end

  def value
    content = ActionText::Content.new(super)

    plain? ? content.to_plain_text : content.to_s
  end

  def new_record?
    I18n.translate(key, locale: locale, default: "").blank?
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
end
