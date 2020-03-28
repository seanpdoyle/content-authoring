require "application_system_test_case"

class VisitorViewsPageTest < ApplicationSystemTestCase
  test "visitor views page" do
    page = Page.create!(
      name: "The Page",
      content: "<div>The page's content</div>",
      headline: "The page's headline",
      introduction: "<h1>The page's introduction</h1>",
    )

    visit page_path(page)

    assert_selector "h1", text: "The page's headline"
    assert_selector "h1", text: "The page's introduction"
    assert_selector "div", text: "The page's content"
  end
end
