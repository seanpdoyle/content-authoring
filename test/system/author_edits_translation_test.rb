require "application_system_test_case"

class AuthorEditsTranslationTest < ApplicationSystemTestCase
  test "author edits translation" do
    translation = Translation.create!(
      locale: I18n.locale,
      key: "pages.index.hero.headline",
      value: "The First Translation",
    )

    visit root_path
    click_on login_button
    edit_translation("pages.index.hero.headline", "The Next Translation")

    assert_text "The Next Translation"
    assert_no_text "The First Translation"
  end
end
