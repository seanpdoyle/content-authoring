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

document.addEventListener("ajax:complete", (event) => {
  if (event.target.matches(`[data-controller*="fragment-form"]`)) {
    const [ response ] = event.detail
    const container = event.target.parentElement

    container.setAttribute("data-fragment-form-cancel-html", container.innerHTML)
    container.innerHTML = response.responseText
  }
})

document.addEventListener("click", (event) => {
  if (event.target.matches(`[data-fragment-form-cancel-html] button[data-action="cancel"]`)) {
    const container = event.target.closest(`[data-fragment-form-cancel-html]`)

    container.innerHTML = container.getAttribute("data-fragment-form-cancel-html")
  }
})
