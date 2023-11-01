import consumer from "./consumer"

consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    this.scrollToBottom()
  },

  disconnected() {
  },

  received(data) {
    if (data.message_body){
      $('#message-container').append(data.message_body)
      $('#message_body').val('');
      this.scrollToBottom()
    }
  },

  scrollToBottom(){
    $('#message-container').animate({ scrollTop: $('#message-container').prop("scrollHeight") }, 1000)
  }
});
