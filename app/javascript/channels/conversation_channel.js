import { createConsumer } from "@rails/actioncable"

function updateMessageTimes() {
  document.querySelectorAll('.message-time').forEach(timeElement => {
    const timestamp = timeElement.dataset.timestamp
    if (timestamp) {
      const date = new Date(timestamp)
      timeElement.textContent = date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
    }
  })
}

document.addEventListener('turbo:load', () => {
  const element = document.getElementById('messages')
  if (element) {
    const conversationId = element.dataset.conversationId
    createConsumer().subscriptions.create({ 
      channel: "ConversationChannel",
      conversation_id: conversationId
    }, {
      connected() {
        console.log("Connected to conversation channel")
        updateMessageTimes()
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        const messagesContainer = document.getElementById('messages')
        if (messagesContainer) {
          messagesContainer.innerHTML = data.html
          messagesContainer.scrollTop = messagesContainer.scrollHeight
          updateMessageTimes()
        }
      },

      speak(content) {
        this.perform('receive', { 
          conversation_id: conversationId, 
          content: content 
        })
      }
    })
  }
})
