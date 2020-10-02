require "test_helper"

class TranslationsControllerTest < ActionDispatch::IntegrationTest
  test "#create with a valid Translation persists it to the I18n backend" do
    with_translations en: { key: "value" } do
      post translations_path, params: {
        translation: {
          locale: :en,
          key: "key",
          value: "new value",
        }
      }

      assert_redirected_to root_url
      assert_equal "new value", I18n.translate(:key)
    end
  end

  test "#create with an valid Translation responds with an error" do
    with_translations en: {} do
      post translations_path, params: {
        translation: {
          locale: :en,
          key: "missing",
          value: "",
        }
      }

      assert_response :unprocessable_entity
    end
  end
end
