require "application_system_test_case"

class VisitorViewsHomepageTest < ApplicationSystemTestCase
  test "visitor views homepage" do
    page = Page.create!(
      headline: "You should visit this page!",
      name: "An interesting page",
    )

    visit root_path

    assert_text page.headline
    assert_text page.name
  end
end
