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

import autosize from "@github/textarea-autosize"

document.addEventListener("turbolinks:load", () => {
  const editableElements = document.querySelectorAll('[data-controller*="editable"]')

  for (const editableForm of editableElements) {
    editableForm.addEventListener("toggle", (event) => {
      const detailsElement = event.target

      if (detailsElement.open) {
        for (const textarea of detailsElement.querySelectorAll("textarea")) {
          autosize(textarea)
        }

        const field = detailsElement.querySelector(`
          input[type="text"],
          textarea
        `)

        if (field) {
          field.focus()
        }
      }
    })
  }
})
