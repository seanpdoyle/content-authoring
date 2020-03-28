class Page < ApplicationRecord
  has_rich_text :content
  has_rich_text :introduction
  has_rich_text :information

  def name=(name)
    super(name.to_s.strip)
  end

  def headline=(headline)
    super(headline.to_s.strip)
  end
end
