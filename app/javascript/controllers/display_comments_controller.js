import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-comments"
export default class extends Controller {
  static targets = ["comment"]

  connect() {
    console.log("connecté");
  }

  display() {
    this.commentTarget.classList.toggle("d-none");
  }
}
