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

  test "#index renders editors for copy when authenticated" do
    post sessions_path
    get root_path

    assert_response :success
    with_options scope: [:marketings, :index, :hero] do |i18n|
      assert_select "title", text: i18n.translate(:title)
      assert_trix_editor "translation[value]", i18n.translate(:title)
    end
  end

  test "#index renders HTML translations as HTML" do
    with_translations en: { marketings: { index: { hero: { subtitle: { html: "<strong>Bold</strong>" } } } } } do
      get root_path

      assert_response :success
      assert_select ".trix-content strong", text: "Bold"
    end
  end

  private

  def assert_trix_editor(name, value)
    assert_select %{input[type="hidden"][name="#{name}"]:match("value", ?) ~ trix-editor}, value
  end
end
