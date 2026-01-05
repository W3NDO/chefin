import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
  }

  static targets = [ "query" ]

  getTags() {
    console.log(`${this.queryTarget}`)
  }
}