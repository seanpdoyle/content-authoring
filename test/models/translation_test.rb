require "test_helper"

class TranslationTest < ActiveSupport::TestCase
  test "#id returns the translation key" do
    translation = Translation.new(key: "application.key")

    id = translation.id

    assert_equal "application.key", id
  end

  test "#key replaces . with _ when building a key Array" do
    translation = Translation.new(key: "application.key")

    to_key = translation.to_key

    assert_equal ["application_key"], to_key
  end

  test "#new_record? returns true when there isn't an existing key" do
    with_translations en: { existing: "value" } do
      translation = Translation.new(locale: :en, key: "missing")

      assert_predicate translation, :new_record?
    end
  end

  test "#new_record? returns false when there is an existing key" do
    with_translations en: { existing: "value" } do
      translation = Translation.new(locale: :en, key: "existing")

      assert_not_predicate translation, :new_record?
    end
  end

  test "when valid, #save writes to the I18n backend" do
    with_translations en: { key: "value" } do
      translation = Translation.new(locale: :en, key: "key", value: "new value")

      saved = translation.save

      assert saved
      assert_equal "new value", I18n.translate(:key)
    end
  end

  test "when invalid, #save does not change the backend" do
    with_translations en: { key: "value" } do
      translation = Translation.new(locale: :en, key: "key", value: nil)

      saved = translation.save

      assert_not saved
      assert_equal "value", I18n.translate(:key)
    end
  end

  test "#value strips HTML elements for plain text translations" do
    translation = Translation.new(key: :plain, value: "<strong>text</strong>")

    value = translation.value

    assert_equal "text", value
  end

  test "#to_s returns the value for direct interpolation" do
    translation = Translation.new(value: "translation text")

    to_s = translation.to_s

    assert_equal "translation text", to_s
  end

  test "is invalid when the value is empty" do
    translation = Translation.new(value: "")

    valid = translation.validate

    assert_not valid
    assert_includes translation.errors, :value
  end

  test "is invalid when the key is not an existing translation" do
    with_translations en: { existing: "value" } do
      translation = Translation.new(locale: :en, key: "missing")

      valid = translation.validate

      assert_not valid
      assert_includes translation.errors, :key
    end
  end
end
