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

  test "#index interpolates plain text values" do
    with_translations en: { marketings: { index: { hero: { title: "%{count}" } } } } do
      get root_path

      assert_response :success
      assert_select "h1", text: "30 Million"
    end
  end

  test "#index interpolates HTML text values" do
    with_translations en: { marketings: { index: { hero: { subtitle_html: "<em>%{content}</em>" } } } } do
      get root_path

      assert_response :success
      assert_select "em", text: "Lorem ipsum dolor"
    end
  end

  test "#index with a missing interpolation renders the placeholder" do
    with_translations en: { marketings: { index: { hero: { title: "%{missing}" } } } } do
      get root_path

      assert_response :success
      assert_select "h1", text: "%{missing}"
    end
  end
end
