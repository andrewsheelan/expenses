import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "userMenu"]

  connect() {
    // Close menus when clicking outside
    document.addEventListener("click", (event) => {
      if (!this.element.contains(event.target)) {
        this.hideMenu()
        this.hideUserMenu()
      }
    })
  }

  toggleMenu() {
    this.menuTarget.classList.toggle("hidden")
  }

  hideMenu() {
    this.menuTarget.classList.add("hidden")
  }

  toggleUserMenu(event) {
    event.stopPropagation()
    if (this.hasUserMenuTarget) {
      this.userMenuTarget.classList.toggle("hidden")
    }
  }

  hideUserMenu() {
    if (this.hasUserMenuTarget) {
      this.userMenuTarget.classList.add("hidden")
    }
  }
}