require "application_system_test_case"

class VisitorViewsPageTest < ApplicationSystemTestCase
  test "visitor views page" do
    attributes = {
      hero_text: "The Hero Text",
      headline_text: "The Headline",
      body_text: "The contents of the page",
      slug: "the-page",
    }
    page = Page.create!(attributes)

    visit page_path(page.slug)

    assert_selector "h1", text: "The Hero Text"
    assert_selector "h1", text: "The Headline"
    assert_selector "div", text: "The contents of the page"
  end
end
