// app/javascript/controllers/application.js
import { Application } from "@hotwired/stimulus"

export const application = Application.start()

// Вмикає корисні логери:
application.debug = false
window.Stimulus = application
