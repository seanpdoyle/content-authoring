let pathname, scrollY

document.addEventListener("turbolinks:before-visit", () => {
  pathname = window.location.pathname
  scrollY = window.scrollY
})

document.addEventListener("turbolinks:render", () => {
  if (window.location.pathname == pathname) {
    window.scroll(0, scrollY)
  }

  pathname = scrollY = null
})
