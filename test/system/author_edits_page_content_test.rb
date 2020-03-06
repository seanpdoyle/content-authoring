require "application_system_test_case"

class AuthorEditsPageContentTest < ApplicationSystemTestCase
  test "author edits page content" do
    attributes = {
      hero_text: "<h1>The Hero Text</h1>",
      headline_text: "<h1>The Headline</h1>",
      body_text: "<p>The Body</p>",
      slug: "the-page",
    }
    page = Page.create!(attributes)
    new_hero_text = "Newly Edited Hero Text"
    new_headline_text = "New Headline"
    new_body_text = "New Body"

    visit page_path(page.slug)
    click_on login_button
    update_content(:hero_text, new_hero_text)
    update_content(:headline_text, new_headline_text)
    update_content(:body_text, new_body_text)

    assert_text new_hero_text
    assert_text new_headline_text
    assert_text new_body_text
  end
end
