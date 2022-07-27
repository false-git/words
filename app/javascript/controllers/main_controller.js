import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  selectAll() {
    this.element.querySelectorAll("input[name='wordset_id[]']").forEach(function(item) {item.checked = true})
  }
  selectNone() {
    this.element.querySelectorAll("input[name='wordset_id[]']").forEach(function(item) {item.checked = false})
  }
  selectGroup(event) {
    console.log(event.srcElement.value)
    document.cookie = "last_group=" + event.srcElement.value
    location.reload()
  }
  connect() {
    let item = this.element.querySelector("#text_speak")
    if (item != null) {
      this.speak_text(item.value, 0.8)
    }
  }
  speak() {
    this.speak_text(this.element.querySelector("#text_speak").value)
  }
  speak_text(text, rate = 1) {
    let uttr = new SpeechSynthesisUtterance()
    uttr.text = text
    uttr.rate = rate
    uttr.lang = "en-US"
    speechSynthesis.cancel()
    speechSynthesis.speak(uttr)
  }
}
