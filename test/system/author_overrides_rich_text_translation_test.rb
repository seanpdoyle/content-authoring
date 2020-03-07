require "application_system_test_case"

class AuthorOverridesRichTextTranslationTest < ApplicationSystemTestCase
  test "author overrides rich text translation with _html suffix" do
    hero = translate("examples.index.hero_html")

    visit examples_path
    update_rich_text_translation("examples.index.hero_html", "<h1>New Hero</h1>")

    assert_selector "h1", text: "New Hero"
    assert_no_text hero
  end

  test "author overrides rich text translation with .html suffix" do
    example = translate("examples.index.example.html")

    visit examples_path
    update_rich_text_translation("examples.index.example.html", "<h1>New Example</h1>")

    assert_selector "h1", text: "New Example"
    assert_no_text example
  end

  def update_rich_text_translation(key, value)
    within %([data-i18n-key="#{key}"]) do
      click_on "Edit"
    end
    fill_in_rich_text_area label(:translation, :value), with: value
    click_on submit(:translation, :update)
  end
end
