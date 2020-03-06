require "application_system_test_case"

class VisitorViewsPageTest < ApplicationSystemTestCase
  test "visitor views page" do
    attributes = {
      hero_text: "<h1>The Hero Text</h1>",
      headline_text: "<h1>The Headline</h1>",
      body_text: "<div>The contents of the page</div>",
      slug: "the-page",
    }
    page = Page.create!(attributes)

    visit page_path(page.slug)

    assert_selector "h1", text: "The Hero Text"
    assert_selector "h1", text: "The Headline"
    assert_selector "div", text: "The contents of the page"
  end
end
