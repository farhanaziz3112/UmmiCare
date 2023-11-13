import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/chatmodel.dart';

class chatDatabase {
  final String chatId;
  chatDatabase({required this.chatId});

  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('Chat');

  Future<void> updateChatData(
      String advisorId, String parentId) async {
    return await chatCollection
        .doc(chatId)
        .set({'chatId': chatId, 'advisorId': advisorId, 'parentId': parentId});
  }

  Stream<chatModel> get chatData {
    return chatCollection.doc(chatId).snapshots().map(_createChatModel);
  }

  chatModel _createChatModel(DocumentSnapshot snapshot) {
    return chatModel(
        chatId: snapshot['chatId'],
        advisorId: snapshot['advisorId'],
        parentId: snapshot['parentId']);
  }

  Future<void> updateMessageData(
      String messageId, String senderId, String recipientId, String content, String type) async {
    return await chatCollection.doc(chatId).collection('Message').doc(messageId).set({
      'messageId': messageId,
      'senderId': senderId,
      'recipientId': recipientId,
      'content': content,
      'type': type
    });
  }

  Stream<List<messageModel>> get allMessages {
    return chatCollection
        .doc(chatId)
        .collection('Message')
        .snapshots()
        .map(_createMessagesList);
  }

  List<messageModel> _createMessagesList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return messageModel(
        messageId: doc.data().toString().contains('messageId')
            ? doc.get('messageId')
            : '',
        senderId: doc.data().toString().contains('senderId')
            ? doc.get('senderId')
            : '',
        recipientId: doc.data().toString().contains('recipientId')
            ? doc.get('recipientId')
            : '',
        content:
            doc.data().toString().contains('content') ? doc.get('content') : '',
        type: doc.data().toString().contains('type') ? doc.get('type') : '',
      );
    }).toList();
  }
}
