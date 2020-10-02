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
    overrides = I18n::Backend::Simple.new.tap(&:eager_load!)
    translations.each { |locale, data| overrides.store_translations(locale, data) }

    *chained, defaults = I18n.backend.backends
    backend_with_overrides = I18n::Backend::Chain.new(*chained, overrides)

    backend, I18n.backend = I18n.backend, backend_with_overrides

    block.call
  ensure
    I18n.backend = backend
  end
end
