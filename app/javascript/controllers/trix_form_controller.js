import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "editor", "toolbarAddition" ]

  connect() {
    const buttonRow = this.toolbarTarget.querySelector(".trix-button-row")

    for (const target of this.toolbarAdditionTargets) {
      if (buttonRow) buttonRow.append(target)
    }

    this.dismiss()
  }

  showToolbar({ target }) {
    this.toggleToolbar({ visible: target === this.editorTarget })
  }

  dismissDismissUnlessFocused({ target: { toolbarElement } }) {
    this.toggleToolbar({ visible: toolbarElement === this.toolbarTarget })
  }

  dismissUnlessContained({ target }) {
    if (this.element.contains(target)) return

    this.dismiss()
  }

  dismiss() {
    this.toggleToolbar({ visible: false })
  }

  reject(event) {
    event.preventDefault()
  }

  toggleToolbar({ visible }) {
    this.toolbarTarget.hidden = !visible
  }

  get toolbarTarget() {
    return this.editorTarget.toolbarElement
  }
}
