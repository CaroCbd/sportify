import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"; // You need to import this to use new flatpickr()

// Flatpicker only used for time pickers

export default class extends Controller {
  connect() {
    console.log("controller datepickr connecté")
    flatpickr(this.element, {
      enableTime: true,
      noCalendar: true,
      dateFormat: "H:i",
      time_24hr: true
    })
  }
}
