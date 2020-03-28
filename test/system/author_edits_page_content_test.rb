require "application_system_test_case"

class AuthorEditsPageContentTest < ApplicationSystemTestCase
  test "author edits page content" do
    old_headline = "The Original Page Headline"
    old_name = "The Original Page Name"
    Page.create!(
      headline: old_headline,
      name: old_name,
    )
    new_headline = "The New Page Headline"
    new_name = "The New Page Name"

    visit root_path
    click_on login_button
    edit_attribute(:headline, new_headline)
    edit_attribute(:name, new_name)

    assert_text new_headline
    assert_text new_name
    assert_no_text old_headline
    assert_no_text old_name
  end
end
