import 'package:flutter/material.dart';
import 'package:ummicare/models/buddyModel.dart';
import 'package:ummicare/services/buddyDatabase.dart';

class buddyFriendTile extends StatefulWidget {
  const buddyFriendTile(
      {super.key, required this.profileId, required this.userId});
  final String profileId;
  final String userId;

  @override
  State<buddyFriendTile> createState() => _buddyFriendTileState();
}

class _buddyFriendTileState extends State<buddyFriendTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<buddyProfileModel>(
      stream: buddyDatabase().buddyProfileData(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          buddyProfileModel? ownerProfile = snapshot.data;
          return StreamBuilder<buddyProfileModel>(
            stream: buddyDatabase().buddyProfileData(widget.profileId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                buddyProfileModel? profile = snapshot.data;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 15, 10),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0,
                              blurRadius: 1,
                            )
                          ]),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.grey[300],
                                backgroundImage:
                                    NetworkImage(profile!.buddyProfileImageURL),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text(
                                profile.buddyProfileUsername,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          StreamBuilder<friendModel>(
                              stream: buddyDatabase().friendData(
                                  profile.buddyProfileId,
                                  ownerProfile!.buddyProfileId),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.green[800],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: const Text(
                                        "Followed",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                } else {
                                  return StreamBuilder<
                                          List<friendRequestModel>>(
                                      stream: buddyDatabase()
                                          .allFriendRequestDataWithId(
                                              ownerProfile.buddyProfileId,
                                              profile.buddyProfileId),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data!.isEmpty) {
                                            return Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  buddyDatabase()
                                                      .createFriendRequestData(
                                                          ownerProfile
                                                              .buddyProfileId,
                                                          profile
                                                              .buddyProfileId,
                                                          'pending');
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color(0xff8290F0),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0))),
                                                  child: const Text(
                                                    "Follow",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[500],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                5.0))),
                                                child: const Text(
                                                  "Pending",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          }
                                        } else {
                                          return Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                buddyDatabase()
                                                    .createFriendRequestData(
                                                        ownerProfile
                                                            .buddyProfileId,
                                                        profile.buddyProfileId,
                                                        'pending');
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: const BoxDecoration(
                                                    color: Color(0xff8290F0),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0))),
                                                child: const Text(
                                                  "Follow",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      });
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
