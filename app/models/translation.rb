class Translation
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :locale, :string, default: -> { I18n.locale }
  attribute :key, :string
  attribute :value, :string

  validates :value, presence: true
  validate { errors.add(:key, :invalid) if new_record? }

  def id
    key
  end

  def value
    content = ActionText::Content.new(super)

    content.to_plain_text
  end

  def new_record?
    I18n.translate(key, locale: locale, default: "").blank?
  end

  def save
    if valid?
      I18n.backend.store_translations(locale, { key => value })
      true
    else
      false
    end
  end

  def to_key
    [key.gsub(".", "_")]
  end

  def to_s
    value
  end
end
