import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.isOpen = false
  }

  toggle(event) {
    event.preventDefault()
    event.stopPropagation()
    
    this.isOpen = !this.isOpen
    
    if (this.isOpen) {
      this.open()
    } else {
      this.close()
    }
  }

  open() {
    this.menuTarget.classList.remove("hidden")
    this.menuTarget.classList.add("animate-fadeIn")
    this.element.querySelector("button").setAttribute("aria-expanded", "true")
    
    // Close on outside click
    setTimeout(() => {
      document.addEventListener("click", this.handleOutsideClick)
      document.addEventListener("keydown", this.handleEscape)
    }, 10)
  }

  close() {
    this.menuTarget.classList.add("hidden")
    this.menuTarget.classList.remove("animate-fadeIn")
    this.element.querySelector("button").setAttribute("aria-expanded", "false")
    
    document.removeEventListener("click", this.handleOutsideClick)
    document.removeEventListener("keydown", this.handleEscape)
  }

  handleOutsideClick = (event) => {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }

  handleEscape = (event) => {
    if (event.key === "Escape") {
      this.close()
    }
  }

  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick)
    document.removeEventListener("keydown", this.handleEscape)
  }
}