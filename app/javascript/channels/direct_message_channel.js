import consumer from "./consumer";

document.addEventListener('DOMContentLoaded', () => {
    fetch('/chatroom-ids')
        .then(response => response.json())
        .then(data => {
            const chatroomIds = data.chatroom_ids || [];
            subscribeToChatrooms(chatroomIds);
        })
        .catch(error => console.error('Error fetching chatroom IDs:', error));

    function subscribeToChatrooms(chatroomIds) {
        chatroomIds.forEach(chatroomId => {
            let container_id = `#message-container-${chatroomId}`
            consumer.subscriptions.create({channel: "DirectMessageChannel", chatroom_id: chatroomId}, {
                connected() {
                    this.scrollToBottom()
                },
                received(data) {
                    console.log(data)
                    if (data.message_body) {
                        $(container_id).append(data.message_body)
                        $('#direct_message_body').val('');
                        this.scrollToBottom()
                    }
                },
                scrollToBottom() {
                    $(container_id).animate({scrollTop: $(container_id).prop("scrollHeight")}, 1000)
                }
            })
        })
    }
})