require "test_helper"

class MarketingsControllerTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::TranslationHelper

  test "#index renders marketing copy" do
    get root_path

    with_options scope: [:marketings, :index, :hero] do |i18n|
      assert_select "title", text: i18n.translate(:title)
      assert_select "h1", text: i18n.translate(:title)
    end
  end
end
