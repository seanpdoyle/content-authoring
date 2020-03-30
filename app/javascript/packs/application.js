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

require("trix")
require("@rails/actiontext")

import "form-request-submit-polyfill"
import autosize from "@github/textarea-autosize"

const focusIn = (detailsElement) => {
  const field = detailsElement.querySelector(`
    input[type="text"],
    textarea,
    trix-editor
  `)

  if (field) {
    field.focus()
  }
}

document.addEventListener("turbolinks:before-render", (event) => {
  const scrollTop = document.body.getAttribute("data-scroll-top")
  const newBody = event.data.newBody

  if (scrollTop) {
    newBody.setAttribute("data-scroll-top", scrollTop)
  }
})

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

  if (document.body.hasAttribute("data-scroll-top")) {
    const scrollTop = document.body.getAttribute("data-scroll-top")

    document.scrollingElement.scrollTop = scrollTop

    document.body.removeAttribute("data-scroll-top")
  }
})

document.addEventListener("ajax:success", (event) => {
  const form = event.target

  if (form.matches(`[data-controller*="preserve-scroll"]`)) {
    const scrollTop = document.scrollingElement.scrollTop

    document.body.setAttribute("data-scroll-top", scrollTop)
  }

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

document.addEventListener("input", (event) => {
  const input = event.target
  const form = input.form

  if (input.matches('[data-controller*="file-upload-preview"] input[type="file"]')) {
    const previewImage = form.querySelector("img")

    if (!previewImage.hasAttribute("data-file-upload-preview-reset-src")) {
      previewImage.setAttribute("data-file-upload-preview-reset-src", previewImage.src)
    }

    for (const file of input.files) {
      previewImage.src = URL.createObjectURL(file)
    }
  }
})

document.addEventListener("reset", (event) => {
  const form = event.target

  if (form.matches('[data-controller*="file-upload-preview"]')) {
    const previewImage = form.querySelector("img")
    const resetSrc = previewImage.getAttribute("data-file-upload-preview-reset-src")

    if (resetSrc) {
      previewImage.src = resetSrc
    }
  }
})
