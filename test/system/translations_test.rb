require "application_system_test_case"

class TranslationsTest < ApplicationSystemTestCase
  include ActionView::Helpers::TranslationHelper

  test "edit translations" do
    key = "marketings.index.hero.title"
    translation = translate(key)

    visit root_path
    click_on "Edit"
    within("h1") { fill_in_rich_text_area with: "New Hero Title" }
    click_on "Save"

    within "h1" do
      assert_text "New Hero Title"
      assert_no_text translation
    end
  end
end
