import consumer from "./consumer"

consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    $('#message-container').append(data.mod_message)
    document.getElementById('message_body').value = ''
    document.getElementsByClassName('ui  feed')[0].scroll(0,innerHeight)
  }
});
