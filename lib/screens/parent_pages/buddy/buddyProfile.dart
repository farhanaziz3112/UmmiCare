import 'package:flutter/material.dart';
import 'package:ummicare/models/buddyModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddyEditProfile.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddylist/buddyFriendList.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddylist/buddyPostList.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddylist/buddyRequestList.dart';
import 'package:ummicare/services/buddyDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';

class buddyProfile extends StatefulWidget {
  const buddyProfile({super.key, required this.buddyProfileId});
  final String buddyProfileId;

  @override
  State<buddyProfile> createState() => _buddyProfileState();
}

class _buddyProfileState extends State<buddyProfile> {
  bool togglePage = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<buddyProfileModel>(
      stream: buddyDatabase().buddyProfileData(widget.buddyProfileId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          buddyProfileModel? profile = snapshot.data;
          return StreamBuilder<parentModel>(
              stream:
                  parentDatabase(parentId: profile!.buddyProfileId).parentData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  parentModel? parent = snapshot.data;
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        profile.buddyProfileUsername,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      iconTheme: const IconThemeData(color: Colors.black),
                      centerTitle: true,
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      elevation: 3,
                    ),
                    resizeToAvoidBottomInset: false,
                    body: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 30.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: CircleAvatar(
                                      radius: 35.0,
                                      backgroundColor: Colors.grey[300],
                                      backgroundImage: NetworkImage(
                                          profile.buddyProfileImageURL),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          profile.buddyProfileUsername,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          parent!.parentEmail,
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 11),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    buddyEditProfile(
                                                        buddyProfileId: profile
                                                            .buddyProfileId)),
                                          );
                                        },
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(height: 25),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Posts',
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        StreamBuilder<List<buddyPostModel>>(
                                            stream: buddyDatabase()
                                                .allBuddyPostDataWithProfileId(
                                                    profile.buddyProfileId),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  snapshot.data!.length
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                );
                                              } else {
                                                return Container();
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Friends',
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        StreamBuilder<List<friendModel>>(
                                            stream: buddyDatabase()
                                                .allFriendData(
                                                    profile.buddyProfileId),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  snapshot.data!.length
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                );
                                              } else {
                                                return const Text(
                                                  '0',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                );
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Status',
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          profile.isPrivate == 'private' ? 'Private' : 'Public',
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextButton(
                                    style: togglePage
                                        ? TextButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff8290F0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          )
                                        : TextButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.photo,
                                          color: togglePage
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          'Posts',
                                          style: togglePage
                                              ? const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0)
                                              : const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        togglePage = true;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextButton(
                                    style: !togglePage
                                        ? TextButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff8290F0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          )
                                        : TextButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.group,
                                          color: !togglePage
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Friend',
                                          style: !togglePage
                                              ? const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0)
                                              : const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        togglePage = false;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Container(
                                height: 1.0,
                                width: double.infinity,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 20),
                            togglePage
                                ? StreamBuilder<List<buddyPostModel>>(
                                    stream: buddyDatabase()
                                        .allBuddyPostDataWithProfileId(
                                            profile.buddyProfileId),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<buddyPostModel>? postsList =
                                            snapshot.data;
                                        return buddyPostlist(posts: postsList);
                                      } else {
                                        return Container();
                                      }
                                    },
                                  )
                                : Container(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'Friend Requests',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 15),
                                        StreamBuilder<List<friendRequestModel>>(
                                          stream: buddyDatabase()
                                              .allFriendRequestDataWithReceiverIdAndStatus(
                                                  'pending',
                                                  profile.buddyProfileId),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<friendRequestModel>?
                                                  friendRequests =
                                                  snapshot.data;
                                              return buddyRequestList(
                                                  ownerId:
                                                      profile.buddyProfileId,
                                                  requestList: friendRequests);
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 50),
                                        const Text(
                                          'Your Friend',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 15),
                                        StreamBuilder<List<friendModel>>(
                                          stream: buddyDatabase().allFriendData(
                                              profile.buddyProfileId),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<friendModel>?
                                                  friendRequests =
                                                  snapshot.data;
                                              return buddyFriendList(
                                                profileList: friendRequests,
                                                userId: profile.buddyProfileId,
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                          ],
                        ),
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
