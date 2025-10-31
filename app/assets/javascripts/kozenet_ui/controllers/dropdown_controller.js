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
    if (this.hasMenuTarget) {
      this.menuTarget.classList.remove("hidden")
      this.menuTarget.classList.add("animate-fadeIn")
      this.element.setAttribute("aria-expanded", "true")
      
      // Close on outside click
      setTimeout(() => {
        document.addEventListener("click", this.closeOnOutsideClick)
      }, 10)
    }
  }

  close() {
    if (this.hasMenuTarget) {
      this.menuTarget.classList.add("hidden")
      this.menuTarget.classList.remove("animate-fadeIn")
      this.element.setAttribute("aria-expanded", "false")
      
      document.removeEventListener("click", this.closeOnOutsideClick)
    }
  }

  closeOnOutsideClick = (event) => {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }

  disconnect() {
    document.removeEventListener("click", this.closeOnOutsideClick)
  }
}