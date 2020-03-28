class Page < ApplicationRecord
  def name=(name)
    super(name.to_s.strip)
  end

  def headline=(headline)
    super(headline.to_s.strip)
  end
end
