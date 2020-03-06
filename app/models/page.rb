class Page < ApplicationRecord
  has_rich_text :hero_text
  has_rich_text :headline_text
  has_rich_text :body_text
end
