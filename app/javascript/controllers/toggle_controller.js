import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["toggle"]
  connect() {
    console.log("on est au toggler")
  }

  list(event){
    console.log("liste");
    document.getElementById("list").checked = true;
    document.getElementById("map-view").classList.add("d-none");
    document.getElementById("list-view").classList.remove("d-none");
  }

  map(event){
    console.log("carte");
    document.getElementById("map").checked = true;
    document.getElementById("list-view").classList.add("d-none");
    document.getElementById("map-view").classList.remove("d-none");
  }
}
