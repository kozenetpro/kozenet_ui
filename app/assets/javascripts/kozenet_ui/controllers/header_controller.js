import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    this.scrolled = false
  }

  handleScroll() {
    const scrollPosition = window.scrollY
    
    if (scrollPosition > 10 && !this.scrolled) {
      this.scrolled = true
      this.element.classList.add("kz-header-scrolled")
    } else if (scrollPosition <= 10 && this.scrolled) {
      this.scrolled = false
      this.element.classList.remove("kz-header-scrolled")
    }
  }

  toggleSearch(event) {
    event.preventDefault()
    const searchCol = this.element.querySelector(".kz-search-col")
    if (searchCol) {
      searchCol.classList.toggle("hidden")
      searchCol.classList.toggle("block")
      const input = searchCol.querySelector("input")
      if (input) input.focus()
    }
  }
}