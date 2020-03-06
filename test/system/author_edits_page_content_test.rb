require "application_system_test_case"

class AuthorEditsPageContentTest < ApplicationSystemTestCase
  include ActionView::Helpers::TranslationHelper

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
    within("h1", text: page.hero_text) do
      edit_content(:hero_text, new_hero_text)
    end
    within("h1", text: page.headline_text) do
      edit_content(:headline_text, new_headline_text)
    end
    within("div", text: page.body_text) do
      edit_content(:body_text, new_body_text)
    end

    assert_selector "h1", text: new_hero_text
    assert_selector "h1", text: new_headline_text
    assert_selector "div", text: new_body_text
  end

  def login_button
    translate("helpers.submit.session.create")
  end

  def edit_content(attribute, value)
    click_on translate("pages.edit_button.button_html", attribute: "")
    fill_in_rich_text_area translate(attribute, scope: "helpers.label.page"), with: value
    click_on translate("helpers.submit.page.update")
  end
end
