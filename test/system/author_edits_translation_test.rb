require "application_system_test_case"

class AuthorEditsTranslationTest < ApplicationSystemTestCase
  test "author edits translation" do
    attributes = {
      locale: :en,
      key: "examples.index.title",
      value: "The First Edit",
    }
    translation = Translation.create!(attributes)

    visit examples_path
    within %([data-i18n-key="#{translation.key}"]) do
      click_on "Edit"
      fill_in label(:translation, :value), with: "The Next Edit"
      click_on submit(:translation, :update)
    end

    assert_text "The Next Edit"
    assert_no_text "The First Edit"
  end
end
