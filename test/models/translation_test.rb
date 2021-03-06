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

  test "#html? returns true when the key ends with html" do
    assert_predicate Translation.new(key: "key_html"), :html?
    assert_predicate Translation.new(key: "key.html"), :html?
    assert_predicate Translation.new(key: "html"), :html?
  end

  test "#html? returns false when the key does not end with html" do
    assert_not_predicate Translation.new(key: "key"), :html?
    assert_not_predicate Translation.new(key: "html.key"), :html?
  end

  test "#plain? returns true when the key does no end with html" do
    assert_predicate Translation.new(key: "key"), :plain?
    assert_predicate Translation.new(key: "html.key"), :plain?
  end

  test "#plain? returns false when the key ends with html" do
    assert_not_predicate Translation.new(key: "key_html"), :plain?
    assert_not_predicate Translation.new(key: "key.html"), :plain?
    assert_not_predicate Translation.new(key: "html"), :plain?
  end

  test "#value contains HTML elements for HTML translations" do
    translation = Translation.new(key: :html, value: "<strong>text</strong>")

    value = translation.value

    assert_equal "<strong>text</strong>", value
  end

  test "#value strips HTML elements for plain text translations" do
    translation = Translation.new(key: :plain, value: "<strong>text</strong>")

    value = translation.value

    assert_equal "text", value
  end

  test "#interpolations returns pairings of placeholders and replacements" do
    with_translations en: { key: "%{count} %{name}" } do
      translation = Translation.new(key: :key, options: { count: 1, name: "foo" })

      interpolations = translation.interpolations

      assert_equal({ count: "1", name: "foo" }, interpolations)
    end
  end

  test "#interpolations omits replacements that are placeholders" do
    with_translations en: { key: "%{count} %{name}" } do
      translation = Translation.new(key: :key, options: { count: 1, name: "%{name}" })

      interpolations = translation.interpolations

      assert_equal({ count: "1" }, interpolations)
    end
  end

  test "#template renders plain text translation placeholders" do
    with_translations en: { key: "%{count}" } do
      translation = Translation.new(key: :key)

      template = translation.template

      assert_equal "%{count}", template.to_s
    end
  end

  test "#template renders HTML translation placeholders" do
    with_translations en: { html: "<em>%{count}</em>" } do
      translation = Translation.new(key: :html)

      template = translation.template

      assert_equal "<em>%{count}</em>", template.to_s
    end
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
