require "application_system_test_case"

class AuthorEditsPageContentTest < ApplicationSystemTestCase
  include ActionView::Helpers::TranslationHelper

  test "author edits page content" do
    attributes = {
      hero_text: "The Hero Text",
      headline_text: "The Headline",
      body_text: "The Body",
      slug: "the-page",
    }
    page = Page.create!(attributes)
    new_hero_text = "Newly Edited Hero Text"
    new_headline_text = "New Headline"
    new_body_text = "New Body"

    visit page_path(page.slug)
    click_on login_button
    within("h1", text: page.hero_text) do
      expand translate("pages.show.edit")
      fill_in translate("helpers.label.page.hero_text"), with: new_hero_text
      click_on translate("helpers.submit.page.update")
    end
    within("h1", text: page.headline_text) do
      expand translate("pages.show.edit")
      fill_in translate("helpers.label.page.headline_text"), with: new_headline_text
      click_on translate("helpers.submit.page.update")
    end
    within("div", text: page.body_text) do
      expand translate("pages.show.edit")
      fill_in translate("helpers.label.page.body_text"), with: new_body_text
      click_on translate("helpers.submit.page.update")
    end

    assert_selector "h1", text: new_hero_text
    assert_selector "h1", text: new_headline_text
    assert_selector "div", text: new_body_text
  end

  def expand(label)
    find("summary", text: label).click
  end

  def login_button
    translate("helpers.submit.session.create")
  end
end
