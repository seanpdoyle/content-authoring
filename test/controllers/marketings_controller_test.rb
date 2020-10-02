require "test_helper"

class MarketingsControllerTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::TranslationHelper

  test "#index renders editors for copy" do
    get root_path

    assert_response :success
    with_options scope: [:marketings, :index, :hero] do |i18n|
      assert_select "title", text: i18n.translate(:title)
      assert_trix_editor "translation[value]", i18n.translate(:title)
    end
  end

  private

  def assert_trix_editor(name, value)
    assert_select %{input[type="hidden"][name="#{name}"]:match("value", ?) ~ trix-editor}, value
  end
end
