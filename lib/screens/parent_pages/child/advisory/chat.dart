import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/advisormodel.dart';
import 'package:ummicare/models/chatmodel.dart';
import 'package:ummicare/services/advisorDatabase.dart';
import 'package:ummicare/services/chatDatabase.dart';
import 'package:ummicare/services/storage.dart';

class chat extends StatefulWidget {
  final String advisorId;
  final String parentId;
  const chat({super.key, required this.advisorId, required this.parentId});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  late File imageFile;
  String imageUrl = '';
  String chatId = '';
  String advisorId = '';
  String parentId = '';
  List<messageModel> listMessage = [];

  int _limit = 20;
  int _limitIncrement = 20;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  _scrollToEnd(int time) async {
    listScrollController.animateTo(listScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: time), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    chatId = '${widget.advisorId}${widget.parentId}';
    advisorId = widget.advisorId;
    parentId = widget.parentId;
    return StreamBuilder<advisorModel>(
      stream: advisorDatabase(advisorId: widget.advisorId).advisorData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          advisorModel? advisor = snapshot.data;
          _scrollToEnd(1);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                advisor!.advisorFirstName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 3,
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            ),
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                  children: <Widget>[buildListMessage(), buildInput()],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'No Data',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 3,
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            ),
          );
        }
      },
    );
  }

  Widget buildItem(int index, messageModel message) {
    if (message.senderId == parentId) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          message.type == 'text'
              ? Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    message.content,
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              : Container(
                  child: OutlinedButton(
                    onPressed: () {},
                    style:
                        OutlinedButton.styleFrom(backgroundColor: Colors.grey),
                    child: Material(
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Image.network(
                          message.content,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      );
    } else if (message.senderId == advisorId) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          message.type == 'text'
              ? Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    message.content,
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              : Container(
                  child: OutlinedButton(
                    onPressed: () {},
                    style:
                        OutlinedButton.styleFrom(backgroundColor: Colors.grey),
                    child: Material(
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Image.network(
                          message.content,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder<List<messageModel>>(
        stream: chatDatabase(chatId: chatId).allMessages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<messageModel>? listMessages = snapshot.data;
            if (listMessages!.length > 0) {
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) =>
                    buildItem(index, listMessages.elementAt(index)),
                itemCount: listMessages.length,
                reverse: false,
                controller: listScrollController,
              );
            } else {
              return const Center(
                child: Text('No message here yet....'),
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildInput() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white, width: 0.5)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: const Icon(Icons.image),
                onPressed: getImage,
                color: Colors.black,
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: const Icon(Icons.face),
                onPressed: () {},
                color: Colors.black,
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, 'text');
                },
                style: TextStyle(color: Colors.black, fontSize: 15),
                controller: textEditingController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.black),
                ),
                autofocus: true,
                focusNode: focusNode,
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  onSendMessage(textEditingController.text, 'text');
                },
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      String imageURL = await StorageService().uploadChatImage(pickedFile);
      onSendMessage(imageURL, 'image');
    }
  }

  void onSendMessage(String content, String type) {
    textEditingController.clear();
    chatDatabase(chatId: chatId).updateMessageData(
        DateTime.now().millisecondsSinceEpoch.toString(),
        parentId,
        advisorId,
        content,
        type);
    if (listScrollController.hasClients) {
      _scrollToEnd(3000);
    }
  }
}
