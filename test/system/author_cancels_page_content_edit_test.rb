require "application_system_test_case"

class AuthorCancelsPageContentEditTest < ApplicationSystemTestCase
  include ActionView::Helpers::TranslationHelper

  test "author cancels page content edit" do
    attributes = {
      hero_text: "<h1>The Hero Text</h1>",
      headline_text: "<h1>The Headline</h1>",
      body_text: "<p>The Body</p>",
      slug: "the-page",
    }
    page = Page.create!(attributes)
    new_hero_text = "Newly Edited Hero Text"

    visit url_for(page.slug)
    within("h1", text: page.hero_text) do
      click_on translate("pages.edit_button.button_html", attribute: "")
      fill_in_rich_text_area translate(:hero_text, scope: "helpers.label.page"), with: new_hero_text
      click_on translate("helpers.submit.page.cancel")
    end

    assert_text "The Hero Text"
    assert_no_text new_hero_text
  end
end
