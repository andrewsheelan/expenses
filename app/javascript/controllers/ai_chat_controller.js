import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["messages", "input", "content", "toggleIcon"]

  connect() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    this.isMinimized = false
  }

  toggle(event) {
    event.preventDefault()
    this.isMinimized = !this.isMinimized
    
    if (this.isMinimized) {
      this.contentTarget.style.display = "none"
      this.toggleIconTarget.classList.remove("fa-minus")
      this.toggleIconTarget.classList.add("fa-plus")
    } else {
      this.contentTarget.style.display = "flex"
      this.toggleIconTarget.classList.remove("fa-plus")
      this.toggleIconTarget.classList.add("fa-minus")
    }
  }

  async send(event) {
    event.preventDefault()
    const message = this.inputTarget.value.trim()
    if (!message) return

    // Add user message
    this.addMessage("You", message)
    this.inputTarget.value = ""

    // Send to API
    try {
      const response = await fetch('/ai_chats', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ message })
      })
      const data = await response.json()
      
      // Add AI response
      this.addMessage("AI Assistant", data.message)
    } catch (error) {
      console.error('Error:', error)
      this.addMessage("AI Assistant", "Sorry, there was an error processing your request.")
    }

    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
  }

  addMessage(sender, text) {
    const messageDiv = document.createElement('div')
    messageDiv.className = 'mb-4'
    messageDiv.innerHTML = `
      <p class="text-sm text-pink-400">${sender}</p>
      <p class="text-gray-300">${text}</p>
    `
    this.messagesTarget.appendChild(messageDiv)
  }
}