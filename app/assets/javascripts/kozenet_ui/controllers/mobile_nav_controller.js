import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "trigger"]

  connect() {
    this.isOpen = false
  }

  toggle(event) {
    event.preventDefault()
    this.isOpen = !this.isOpen
    
    if (this.isOpen) {
      this.open()
    } else {
      this.close()
    }
  }

  open() {
    this.panelTarget.classList.remove("hidden", "scale-y-0")
    this.panelTarget.classList.add("scale-y-100")
    this.triggerTarget.setAttribute("aria-expanded", "true")
    document.body.style.overflow = "hidden"
  }

  close() {
    this.panelTarget.classList.add("scale-y-0")
    this.panelTarget.classList.remove("scale-y-100")
    this.triggerTarget.setAttribute("aria-expanded", "false")
    
    setTimeout(() => {
      this.panelTarget.classList.add("hidden")
      document.body.style.overflow = ""
    }, 300)
  }

  // Close on escape key
  disconnect() {
    document.body.style.overflow = ""
  }
}