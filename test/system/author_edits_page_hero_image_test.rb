require "application_system_test_case"

class AuthorEditsPageHeroImageTest < ApplicationSystemTestCase
  test "author edits page hero image" do
    Page.create!(
      headline: "An interesting page",
      name: "The Page",
    )

    visit root_path
    click_on login_button
    expand_attribute_form :hero_image do
      attach_file label(:page, :hero_image), file_fixture("image.png")

      click_on submit(:page, :update)
    end

    assert_selector "img"
  end
end
