class chatModel {
  final String chatId;
  late final String advisorId;
  late final String parentId;

  chatModel({
    required this.chatId,
    required this.advisorId,
    required this.parentId
  });
}


class messageModel {
  final String messageId;
  late final String senderId;
  late final String recipientId;
  late final String content;
  late final String type;

  messageModel({
    required this.messageId,
    required this.senderId,
    required this.recipientId,
    required this.content,
    required this.type
  });
}