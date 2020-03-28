require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include ActionView::Helpers::TranslationHelper

  driven_by :selenium, using: :chrome, screen_size: [1768, 1400]

  def edit_attribute(attribute, content, rich_text: false)
    within %([data-editable-attribute="#{attribute}"]) do
      expand translate("pages.editable.edit_html", attribute: "")

      if rich_text
        fill_in_rich_text_area label(:page, attribute), with: content
      else
        fill_in label(:page, attribute), with: content
      end

      click_on submit(:page, :update)
    end
  end

  def expand(label)
    find("summary", text: label, normalize_ws: true).click
  end

  def login_button
    translate("helpers.submit.session.create")
  end

  def label(model, attribute)
    translate(attribute, scope: [:helpers, :label, model])
  end

  def submit(model, action)
    translate(action, scope: [:helpers, :submit, model])
  end

  # Locates a Trix editor and fills it in with the given HTML.
  #
  # The editor can be found by:
  # * its +id+
  # * its +placeholder+
  # * its +aria-label+
  # * the +name+ of its input
  #
  # Examples:
  #
  #   # <trix-editor id="message_content" ...></trix-editor>
  #   fill_in_rich_text_area "message_content", with: "Hello <em>world!</em>"
  #
  #   # <trix-editor placeholder="Your message here" ...></trix-editor>
  #   fill_in_rich_text_area "Your message here", with: "Hello <em>world!</em>"
  #
  #   # <trix-editor aria-label="Message content" ...></trix-editor>
  #   fill_in_rich_text_area "Message content", with: "Hello <em>world!</em>"
  #
  #   # <input id="trix_input_1" name="message[content]" type="hidden">
  #   # <trix-editor input="trix_input_1"></trix-editor>
  #   fill_in_rich_text_area "message[content]", with: "Hello <em>world!</em>"
  def fill_in_rich_text_area(locator = nil, with:)
    find(:rich_text_area, locator).execute_script("this.editor.loadHTML(arguments[0])", with.to_s)
  end
end

Capybara.add_selector :rich_text_area do
  label "rich-text area"
  xpath do |locator|
    if locator.nil?
      XPath.descendant(:"trix-editor")
    else
      input_located_by_name = XPath.anywhere(:input).where(XPath.attr(:name) == locator).attr(:id)

      XPath.descendant(:"trix-editor").where \
        XPath.attr(:id).equals(locator) |
        XPath.attr(:placeholder).equals(locator) |
        XPath.attr(:"aria-label").equals(locator) |
        XPath.attr(:input).equals(input_located_by_name)
    end
  end
end
