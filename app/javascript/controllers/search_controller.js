import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value
      const frame = document.getElementById(this.inputTarget.dataset.frame)
      const url = this.inputTarget.dataset.searchUrlValue
      
      if (query.length > 0) {
        const searchUrl = `${url}?query=${encodeURIComponent(query)}`
        frame.src = searchUrl
      } else {
        frame.src = url
      }
    }, 300)
  }
}