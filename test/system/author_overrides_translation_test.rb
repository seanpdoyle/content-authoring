require "application_system_test_case"

class AuthorEditsTranslationTest < ApplicationSystemTestCase
  test "author overrides translation" do
    original_title = translate("examples.index.title")

    visit examples_path
    within %([data-i18n-key="examples.index.title"]) do
      click_on "Edit"
      fill_in label(:translation, :value), with: "New Title!"
      click_on submit(:translation, :create)
    end

    assert_text "New Title!"
    assert_no_text original_title
  end
end
