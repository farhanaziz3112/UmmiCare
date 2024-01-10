import 'package:flutter/material.dart';
import 'package:ummicare/models/buddyModel.dart';
import 'package:ummicare/services/buddyDatabase.dart';
import 'package:ummicare/shared/function.dart';

class buddyPostTile extends StatefulWidget {
  const buddyPostTile({super.key, required this.buddyPostId});
  final String buddyPostId;

  @override
  State<buddyPostTile> createState() => _buddyPostTileState();
}

class _buddyPostTileState extends State<buddyPostTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<buddyPostModel>(
      stream: buddyDatabase().buddyPostData(widget.buddyPostId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          buddyPostModel? post = snapshot.data;
          return StreamBuilder<buddyProfileModel>(
              stream: buddyDatabase().buddyProfileData(post!.buddyProfileId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  buddyProfileModel? profile = snapshot.data;
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 10, 2, 20),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0,
                              blurRadius: 1,
                            )
                          ]),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: NetworkImage(
                                      profile!.buddyProfileImageURL),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text(
                                    profile.buddyProfileUsername,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Container(
                              height: 1.0,
                              width: double.infinity,
                              color: Colors.grey[400],
                            ),
                          ),
                          post.buddyPostImageURL != ""
                              ? SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Image.network(
                                      post.buddyPostImageURL,
                                      width: 300,
                                      height: 300,
                                    ),
                                  ))
                              : Container(),
                          const SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              post.buddyPostCaption,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              convertTimeToDateWithStringMonth(post.createdAt),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              });
        } else {
          return Container();
        }
      },
    );
  }
}
