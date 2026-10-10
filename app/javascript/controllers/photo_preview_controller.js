import { Controller } from "@hotwired/stimulus"

// Shows the chosen photo in the form before it is uploaded
export default class extends Controller {
  static targets = [ "input", "preview", "prompt" ]

  show() {
    const file = this.inputTarget.files[0]
    if (!file) return

    this.previewTarget.src = URL.createObjectURL(file)
    this.previewTarget.hidden = false
    this.promptTarget.hidden = true
  }
}
