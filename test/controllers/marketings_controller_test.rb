require "test_helper"

class MarketingsControllerTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::TranslationHelper

  test "#index renders marketing copy" do
    get root_path

    assert_response :success
    with_options scope: [:marketings, :index, :hero] do |i18n|
      assert_select "title", text: i18n.translate(:title)
      assert_select "h1", text: i18n.translate(:title)
    end
  end

  test "#index renders HTML translations as HTML" do
    with_translations en: { marketings: { index: { hero: { subtitle_html: "<strong>Bold</strong>" } } } } do
      get root_path

      assert_response :success
      assert_select ".trix-content strong", text: "Bold"
    end
  end
end
