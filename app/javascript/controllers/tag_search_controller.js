import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static debounces = ['getTags']
  static targets = [ 'tags' ]

  connect() {
    window.StimulusUse.useDebounce(this, { wait: 500 })
  }

  getTags(event) {
    let search_term = event.target.value.toLowerCase()
    let tag_ids = Object.fromEntries(
    this.tagsTargets.map((target) => [
        target.id,                    
        target.id.replaceAll("-", " ")
      ])
    );

    Object.keys(tag_ids).map( (key) => {
      if (!tag_ids[key].includes(search_term)){
        document.getElementById(key).classList.add("hidden")
      } else {
        document.getElementById(key).classList.remove("hidden")
      }
    })
  }
}