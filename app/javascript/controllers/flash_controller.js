import { Controller } from "@hotwired/stimulus"

// Fades flash messages out after a few seconds, or when clicked
export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => this.dismiss(), 5000)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }

  dismiss() {
    this.element.classList.add("flash--leaving")
    setTimeout(() => this.element.remove(), 300)
  }
}
