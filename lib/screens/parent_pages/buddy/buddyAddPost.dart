import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/buddyModel.dart';
import 'package:ummicare/services/buddyDatabase.dart';
import 'package:ummicare/services/storage.dart';
import 'package:ummicare/shared/constant.dart';

class buddyAddPost extends StatefulWidget {
  const buddyAddPost({super.key, required this.buddyProfileId});
  final String buddyProfileId;

  @override
  State<buddyAddPost> createState() => _buddyAddPostState();
}

class _buddyAddPostState extends State<buddyAddPost> {
  final _formKey = GlobalKey<FormState>();

  //form values holder
  String imageUrl = '';
  String caption = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<buddyProfileModel>(
        stream: buddyDatabase().buddyProfileData(widget.buddyProfileId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            buddyProfileModel? profile = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Add New Post",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                elevation: 3,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                iconTheme: const IconThemeData(color: Colors.black),
              ),
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 20.0,
                          ),
                          imageUrl != ''
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border:
                                              Border.all(color: Colors.grey),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Image.network(
                                          imageUrl,
                                          width: 300,
                                          height: 300,
                                        ),
                                      )),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: SizedBox(
                                    height: 300,
                                    width: 300,
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border:
                                              Border.all(color: Colors.grey),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.photo,
                                          size: 50,
                                          color: Colors.grey,
                                        )),
                                  )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                IconButton(
                                  style: IconButton.styleFrom(
                                      backgroundColor: const Color(0xff8290F0)),
                                  icon: const Icon(Icons.camera_alt),
                                  color: Colors.white,
                                  onPressed: () async {
                                    ImagePicker imagePicker = ImagePicker();
                                    XFile? pickedFile = await imagePicker
                                        .pickImage(source: ImageSource.camera);
                                    if (pickedFile != null) {
                                      await StorageService()
                                          .uploadPostPic(pickedFile)
                                          .then((value) {
                                        setState(() {
                                          imageUrl = value;
                                        });
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  style: IconButton.styleFrom(
                                      backgroundColor: const Color(0xff8290F0)),
                                  icon: const Icon(Icons.photo_library),
                                  color: Colors.white,
                                  onPressed: () async {
                                    ImagePicker imagePicker = ImagePicker();
                                    XFile? pickedFile = await imagePicker
                                        .pickImage(source: ImageSource.gallery);
                                    if (pickedFile != null) {
                                      await StorageService()
                                          .uploadPostPic(pickedFile)
                                          .then((value) {
                                        setState(() {
                                          imageUrl = value;
                                        });
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Caption',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextFormField(
                            initialValue: caption,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Caption'),
                            validator: (value) => value == ''
                                ? 'Please enter your caption'
                                : null,
                            onChanged: (value) =>
                                setState(() => caption = value),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff8290F0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: const Text(
                              'Post',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                buddyDatabase().createBuddyPostData(
                                    profile!.buddyProfileId,
                                    imageUrl,
                                    caption,
                                    profile.isPrivate,
                                    DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString());
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
