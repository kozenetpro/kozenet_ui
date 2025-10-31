// Kozenet UI JavaScript Entry Point
import { Application } from "@hotwired/stimulus"

// Import controllers
import HeaderController from "./controllers/header_controller"
import MobileNavController from "./controllers/mobile_nav_controller"
import DropdownController from "./controllers/dropdown_controller"
import UserMenuController from "./controllers/user_menu_controller"

// Start Stimulus application
const application = Application.start()

// Configure Stimulus
application.debug = false
window.Stimulus = application

// Register controllers with kz- prefix
application.register("kz-header", HeaderController)
application.register("kz-mobile-nav", MobileNavController)
application.register("kz-dropdown", DropdownController)
application.register("kz-user-menu", UserMenuController)

export { application }