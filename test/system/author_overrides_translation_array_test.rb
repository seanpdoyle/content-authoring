require "application_system_test_case"

class AuthorOverridesTranslationListTest < ApplicationSystemTestCase
  test "author overrides translation array" do
    first, *rest, last = translate("pages.index.services.value.items")

    visit root_path
    click_on login_button
    edit_translation "pages.index.services.value.items[0]", "New Value"

    assert_no_text first
    assert_text "New Value"
    assert_text last
  end
end
