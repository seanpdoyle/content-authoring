ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def with_translations(translations, &block)
    original = I18n.backend
    *others, defaults = I18n.backend.backends
    overrides = I18n::Backend::Simple.new

    I18n.backend = I18n::Backend::Chain.new(
      *others,
      overrides
    )
    translations.each { |locale, data| overrides.store_translations(locale, data) }

    block.call
  ensure
    I18n.backend = original
  end
end
