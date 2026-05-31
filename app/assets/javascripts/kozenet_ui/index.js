// Kozenet UI JavaScript Entry Point
import { Application, Controller } from "@hotwired/stimulus"

class HeaderController extends Controller {
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

class MobileNavController extends Controller {
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
    if (!this.hasPanelTarget || !this.hasTriggerTarget) return

    this.panelTarget.classList.remove("hidden", "scale-y-0")
    this.panelTarget.classList.add("scale-y-100")
    this.triggerTarget.setAttribute("aria-expanded", "true")
    document.body.style.overflow = "hidden"
  }

  close() {
    if (!this.hasPanelTarget || !this.hasTriggerTarget) return

    this.panelTarget.classList.add("scale-y-0")
    this.panelTarget.classList.remove("scale-y-100")
    this.triggerTarget.setAttribute("aria-expanded", "false")

    setTimeout(() => {
      this.panelTarget.classList.add("hidden")
      document.body.style.overflow = ""
    }, 300)
  }

  disconnect() {
    document.body.style.overflow = ""
  }
}

class DropdownController extends Controller {
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
    if (!this.hasMenuTarget) return

    this.menuTarget.classList.remove("hidden")
    this.menuTarget.classList.add("animate-fadeIn")
    this.element.setAttribute("aria-expanded", "true")

    setTimeout(() => {
      document.addEventListener("click", this.closeOnOutsideClick)
    }, 10)
  }

  close() {
    if (!this.hasMenuTarget) return

    this.menuTarget.classList.add("hidden")
    this.menuTarget.classList.remove("animate-fadeIn")
    this.element.setAttribute("aria-expanded", "false")

    document.removeEventListener("click", this.closeOnOutsideClick)
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

class UserMenuController extends Controller {
  static targets = ["dropdown"]

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
    if (!this.hasDropdownTarget) return

    this.dropdownTarget.classList.remove("hidden")
    this.dropdownTarget.classList.add("animate-fadeIn")
    this.element.querySelector("button")?.setAttribute("aria-expanded", "true")

    setTimeout(() => {
      document.addEventListener("click", this.handleOutsideClick)
      document.addEventListener("keydown", this.handleEscape)
    }, 10)
  }

  close() {
    if (!this.hasDropdownTarget) return

    this.dropdownTarget.classList.add("hidden")
    this.dropdownTarget.classList.remove("animate-fadeIn")
    this.element.querySelector("button")?.setAttribute("aria-expanded", "false")

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

function configuredStimulusPrefix() {
  return document.querySelector("meta[name='kozenet-ui-stimulus-prefix']")?.content?.trim() || "kz"
}

// Auto-initialization function
function startKozenetUi() {
  let application = window.Stimulus
  
  if (!application) {
    application = Application.start()
    application.debug = false
    window.Stimulus = application
  }
  
  window.KozenetUi = Object.assign(window.KozenetUi || {}, {
    stimulusPrefix: configuredStimulusPrefix()
  })
  
  if (!window.KozenetUi.controllersRegistered) {
    Array.from(new Set(["kz", window.KozenetUi.stimulusPrefix])).forEach(prefix => {
      application.register(`${prefix}-header`, HeaderController)
      application.register(`${prefix}-mobile-nav`, MobileNavController)
      application.register(`${prefix}-dropdown`, DropdownController)
      application.register(`${prefix}-user-menu`, UserMenuController)
    })
    window.KozenetUi.controllersRegistered = true
  }
}

// Ensure we initialize after the host app has a chance to set up window.Stimulus
if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", () => setTimeout(startKozenetUi, 10))
} else {
  setTimeout(startKozenetUi, 10)
}

export { HeaderController, MobileNavController, DropdownController, UserMenuController, startKozenetUi as start }
