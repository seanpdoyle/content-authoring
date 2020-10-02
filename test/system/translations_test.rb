require "application_system_test_case"

class TranslationsTest < ApplicationSystemTestCase
  include ActionView::Helpers::TranslationHelper

  test "edit translations" do
    with_translations en: { marketings: { index: { hero: { title: "Old Hero Title" } } } } do
      translation = translate("marketings.index.hero.title")

      visit root_path
      within "h1", text: translation do
        find(:rich_text_area).click
        fill_in_rich_text_area with: "New Hero Title"
        click_on "Save"
      end

      within "h1", text: "New Hero Title" do
        assert_no_text translation
      end
    end
  end
end
