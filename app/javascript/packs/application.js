// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "form-request-submit-polyfill"
import autosize from "@github/textarea-autosize"

const focusIn = (detailsElement) => {
  const field = detailsElement.querySelector(`
    input[type="text"],
    textarea
  `)

  if (field) {
    field.focus()
  }
}

document.addEventListener("turbolinks:load", () => {
  const editableElements = document.querySelectorAll('[data-controller*="editable"]')

  for (const detailsElement of editableElements) {
    detailsElement.addEventListener("toggle", (event) => {
      if (detailsElement.open) {
        const attributeForms = detailsElement.querySelectorAll('[data-controller="attribute-form"]')

        for (const attributeForm of attributeForms) {
          attributeForm.requestSubmit()
        }

        focusIn(detailsElement)
      }
    })
  }
})

document.addEventListener("ajax:success", (event) => {
  const form = event.target

  if (form.matches(`[data-controller*="attribute-form"]`)) {
    const [ response ] = event.detail

    const detailsElement = form.closest('[data-controller*="editable"]')

    form.outerHTML = response.body.innerHTML

    for (const textarea of detailsElement.querySelectorAll("textarea")) {
      autosize(textarea)
    }

    focusIn(detailsElement)

    const loadedClass = detailsElement.getAttribute("data-editable-loaded-class")

    detailsElement.classList.add(loadedClass)
  }
})
