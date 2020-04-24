class Message {
  String name, message, imageUri;

  Message({this.name, this.message, this.imageUri});

  factory Message.fromJson(Map<String, dynamic> msg) {
    return (Message(
        name: msg['name'], message: msg['message'], imageUri: msg['imageUri']));
  }
}

class MessageList {
  List<Message> msgList;

  MessageList({this.msgList});

  factory MessageList.fromJson(List<dynamic> messageList) {
    return (MessageList(
        msgList: messageList.map((i) => Message.fromJson(i)).toList()));
  }
}
