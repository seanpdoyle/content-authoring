require "application_system_test_case"

class AuthorCancelsPageContentEditTest < ApplicationSystemTestCase
  test "author cancels page content edit" do
    attributes = {
      hero_text: "<h1>The Hero Text</h1>",
      headline_text: "<h1>The Headline</h1>",
      body_text: "<p>The Body</p>",
      slug: "the-page",
    }
    page = Page.create!(attributes)
    new_hero_text = "Newly Edited Hero Text"

    visit page_path(page.slug)
    click_on login_button
    edit_content(:hero_text, new_hero_text)
    click_on submit(:page, :cancel)

    assert_text "The Hero Text"
    assert_no_text new_hero_text
  end
end
