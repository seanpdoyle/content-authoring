require "application_system_test_case"

class AuthorEditsTranslationWithInterpolationTest < ApplicationSystemTestCase
  test "author edits translation with interpolation" do
    freeze_time do
      value = translate("layouts.application.footer.copyright", year: Date.current.year)

      visit root_path
      click_on login_button
      edit_translation("layouts.application.footer.copyright", "Made in %{year}")

      assert_text "Made in #{Date.current.year}"
      assert_no_text value
    end
  end
end
