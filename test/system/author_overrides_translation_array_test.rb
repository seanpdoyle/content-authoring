require "application_system_test_case"

class AuthorOverridesTranslationListTest < ApplicationSystemTestCase
  test "author overrides translation array" do
    first, middle, last = translate("examples.index.list_items")

    visit examples_path
    within %([data-i18n-key="examples.index.list_items"]), text: middle do
      click_on "Edit"
      fill_in label(:translation, :value), with: "new value"
      click_on submit(:translation, :create)
    end

    assert_text first
    assert_text "new value"
    assert_text last
    assert_no_text middle
  end
end
