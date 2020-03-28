require "application_system_test_case"

class AuthorEditsTranslationTest < ApplicationSystemTestCase
  test "author overrides translation" do
    headline = translate("pages.index.hero.headline")

    visit root_path
    click_on login_button
    edit_translation("pages.index.hero.headline", "New Headline!")

    assert_text "New Headline!"
    assert_no_text headline
  end
end
