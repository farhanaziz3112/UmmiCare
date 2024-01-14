import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/buddyModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddyAddPost.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddyProfile.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddySearchProfile.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddylist/buddyPostList.dart';
import 'package:ummicare/screens/parent_pages/buddy/registerBuddy.dart';
import 'package:ummicare/services/buddyDatabase.dart';

class buddyMain extends StatefulWidget {
  const buddyMain({super.key});

  @override
  State<buddyMain> createState() => _buddyMainState();
}

class _buddyMainState extends State<buddyMain> {
  bool togglePage = true;

  @override
  Widget build(BuildContext context) {
    parentModel? parent = Provider.of<parentModel?>(context);
    final parentId = parent!.parentId;

    return StreamBuilder<buddyProfileModel>(
      stream: buddyDatabase().buddyProfileData(parentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          buddyProfileModel? buddyProfileDetail = snapshot.data;
          return Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                      child: Row(
                        children: [
                          IconButton(
                            style: IconButton.styleFrom(
                                backgroundColor: const Color(0xff8290F0)),
                            icon: const Icon(Icons.add),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => buddyAddPost(
                                      buddyProfileId:
                                          buddyProfileDetail!.buddyProfileId),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            style: IconButton.styleFrom(
                                backgroundColor: const Color(0xff8290F0)),
                            icon: const Icon(Icons.search),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => buddySearchProfile(
                                      buddyProfileId:
                                          buddyProfileDetail!.buddyProfileId),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )),
                    const Expanded(
                      child: Text(
                        'Buddy',
                        style: TextStyle(fontFamily: 'Pacifico', fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => buddyProfile(
                                  buddyProfileId:
                                      buddyProfileDetail.buddyProfileId),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: NetworkImage(
                              buddyProfileDetail!.buddyProfileImageURL),
                        ),
                      ),
                    ))
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style: togglePage
                            ? TextButton.styleFrom(
                                backgroundColor: const Color(0xff8290F0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              )
                            : TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.public,
                              color: togglePage ? Colors.white : Colors.black,
                            ),
                            Text(
                              'Public',
                              style: togglePage
                                  ? const TextStyle(
                                      color: Colors.white, fontSize: 15.0)
                                  : const TextStyle(
                                      color: Colors.black, fontSize: 15.0),
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
                                backgroundColor: const Color(0xff8290F0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              )
                            : TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.group,
                              color: !togglePage ? Colors.white : Colors.black,
                            ),
                            Text(
                              'Friend',
                              style: !togglePage
                                  ? const TextStyle(
                                      color: Colors.white, fontSize: 15.0)
                                  : const TextStyle(
                                      color: Colors.black, fontSize: 15.0),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 1.0,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                ),
                togglePage
                    ? StreamBuilder<List<buddyPostModel>>(
                        stream: buddyDatabase()
                            .allBuddyPostDataWithStatus('public'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<buddyPostModel>? postsList = snapshot.data;
                            return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: buddyPostlist(posts: postsList));
                          } else {
                            return Container();
                          }
                        },
                      )
                    : StreamBuilder<List<buddyPostModel>>(
                        stream: buddyDatabase().allBuddyPostData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<buddyPostModel>? postsList = snapshot.data;
                            return StreamBuilder<List<friendModel>>(
                              stream: buddyDatabase().allFriendData(
                                  buddyProfileDetail.buddyProfileId),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<friendModel>? friends = snapshot.data;
                                  List<buddyPostModel> posts = [];
                                  for (int i = 0; i < postsList!.length; i++) {
                                    for (int j = 0; j < friends!.length; j++) {
                                      if (postsList[i].buddyProfileId ==
                                          friends[j].friendModelId) {
                                        posts.add(postsList[i]);
                                      }
                                    }
                                  }
                                  return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: buddyPostlist(posts: posts));
                                } else {
                                  return Container();
                                }
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      )
              ],
            ),
          );
        } else {
          return Column(
            children: [
              Container(
                  height: 400,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background/buddymainbg.png"),
                        fit: BoxFit.cover),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(flex: 1, child: Container()),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.group,
                            size: 45,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Buddy",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 45,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'The place where you can share your memories and experiences about your cute children, with the communities!',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 40.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.info),
                            SizedBox(
                                width:
                                    5), // Add some space between icon and text
                            Expanded(
                              child: Text(
                                'Your account does not have a Buddy profile. Register now by clicking on button below!',
                                textAlign: TextAlign.justify,
                                softWrap: true,
                                maxLines: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff8290F0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  registerBuddy(parentId: parentId),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
