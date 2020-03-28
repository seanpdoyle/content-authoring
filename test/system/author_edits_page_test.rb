require "application_system_test_case"

class AuthorEditsPageTest < ApplicationSystemTestCase
  test "author edits page" do
    Page.create!(
      headline: "An interesting page",
      name: "The Page",
    )

    visit root_path
    click_on translate("pages.index.links.show")
    click_on login_button
    edit_attribute(:introduction, <<~HTML, rich_text: true)
      <h1>The Page's introduction</h1>
    HTML
    edit_attribute(:information, <<~HTML, rich_text: true)
      <ul>
        <li>The Page's information</li>
      </ul>
    HTML
    edit_attribute(:content, <<~HTML, rich_text: true)
      <div>The Page's content</div>
    HTML

    assert_selector "h1", text: "The Page's introduction"
    assert_selector "ul li", text: "The Page's information"
    assert_selector "div", text: "The Page's content"
  end
end
