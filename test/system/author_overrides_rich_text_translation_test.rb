require "application_system_test_case"

class AuthorOverridesRichTextTranslationTest < ApplicationSystemTestCase
  test "author overrides rich text translation" do
    content_html = translate("pages.index.services.content_html")

    visit root_path
    click_on login_button
    edit_translation("pages.index.services.content_html", <<~HTML, rich_text: true)
      <h1>New Rich Content</h1>
    HTML

    assert_selector "h1", text: "New Rich Content"
  end
end
