import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/notificationModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/screens/parent_pages/advisor/advisorMain.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddyMain.dart';
import 'package:ummicare/screens/parent_pages/child/childMain.dart';
import 'package:ummicare/screens/parent_pages/notification.dart';
import 'package:ummicare/screens/parent_pages/parent/parentMain.dart';
import 'package:ummicare/screens/parent_pages/settings/parentSettingsMain.dart';
import 'package:ummicare/services/notificationDatabase.dart';
import 'package:ummicare/services/notificationService.dart';
import 'package:ummicare/services/parentDatabase.dart';

class HomeParent extends StatefulWidget {
  const HomeParent({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<HomeParent> createState() => HomeParentState();
}

class HomeParentState extends State<HomeParent> {
  int pageIndex = 0;
  bool isNotificationShown = false;

  final pages = [
    const parentMain(),
    const childMain(),
    const advisorMain(),
    const buddyMain(),
    const parentSettingsMain(),
  ];

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    setState(() {
      pageIndex = widget.currentPage;
    });
    notificationService().init(flutterLocalNotificationsPlugin);
  }


  @override
  Widget build(BuildContext context) {
    parentModel? parent = Provider.of<parentModel?>(context);
    if (parent != null) {
      return StreamBuilder<List<notificationModel>>(
          stream: notificationDatabase()
              .allnotificationDataWithParentIdWithStatus(
                  parent.parentId, 'unseen'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<notificationModel>? notifs = snapshot.data;
              if (notifs!.isEmpty) {
                return Scaffold(
                  appBar: AppBar(
                    elevation: 3.0,
                    actions: <Widget>[
                      StreamBuilder<List<notificationModel>>(
                          stream: notificationDatabase()
                              .allnotificationDataWithParentIdWithStatus(
                                  parent.parentId, 'notified'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<notificationModel>? redDotNoti =
                                  snapshot.data;
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  IconButton(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 15.0, 0.0),
                                    icon: const Icon(
                                      Icons.notifications,
                                      color: Colors.grey,
                                      size: 30.0,
                                    ),
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  notification(parentId: parent.parentId)));
                                    },
                                  ),
                                  redDotNoti!.isNotEmpty
                                      ? Positioned(
                                          bottom: 10,
                                          right: 0,
                                          left: -35,
                                          child: CircleAvatar(
                                            radius: 5,
                                            backgroundColor: Colors.red[800],
                                          ),
                                        )
                                      : Container(),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ],
                    title: Row(
                      children: [
                        Image.asset('assets/background/ummicarelogo.png', width: 40, height: 40),
                        const Text(
                          "UmmiCare",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    centerTitle: false,
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  body: SingleChildScrollView(child: pages[pageIndex]),
                  bottomNavigationBar: buildBottomBar(context),
                );
              } else {
                for (int i = 0; i < notifs.length; i++) {
                  notificationService().showNotification(
                    id: i,
                    title: notifs[i].title,
                    body: notifs[i].description,
                    fln: flutterLocalNotificationsPlugin,
                  );
                  notificationDatabase().updateNotificationData(
                      notifs[i].notificationId,
                      notifs[i].parentId,
                      notifs[i].childId,
                      notifs[i].type,
                      notifs[i].title,
                      notifs[i].description,
                      'notified',
                      notifs[i].createdAt);
                }
                return Scaffold(
                  appBar: AppBar(
                    elevation: 3.0,
                    actions: <Widget>[
                      StreamBuilder<List<notificationModel>>(
                          stream: notificationDatabase()
                              .allnotificationDataWithParentIdWithStatus(
                                  parent.parentId, 'notified'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<notificationModel>? redDotNoti =
                                  snapshot.data;
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  IconButton(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 15.0, 0.0),
                                    icon: const Icon(
                                      Icons.notifications,
                                      color: Colors.grey,
                                      size: 30.0,
                                    ),
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  notification(parentId: parent.parentId)));
                                    },
                                  ),
                                  redDotNoti!.isNotEmpty
                                      ? Positioned(
                                          bottom: 10,
                                          right: 0,
                                          left: -35,
                                          child: CircleAvatar(
                                            radius: 5,
                                            backgroundColor: Colors.red[800],
                                          ),
                                        )
                                      : Container(),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ],
                    title: const Text(
                      "UmmiCare",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: false,
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  body: SingleChildScrollView(child: pages[pageIndex]),
                  bottomNavigationBar: buildBottomBar(context),
                );
              }
            } else {
              return Container();
            }
          });
    } else {
      return Container();
    }
  }

  Container buildBottomBar(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? const Column(
                      children: [
                        Icon(
                          Icons.home,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 40,
                        ),
                      ],
                    )
                  : const Column(
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 30,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
            ),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                icon: pageIndex == 1
                    ? const Column(
                        children: [
                          Icon(
                            Icons.face,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 40,
                          )
                        ],
                      )
                    : const Column(
                        children: [
                          Icon(
                            Icons.face_outlined,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 30,
                          ),
                          Text(
                            'Child',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      )),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                icon: pageIndex == 2
                    ? const Column(
                        children: [
                          Icon(
                            Icons.support_agent,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 40,
                          )
                        ],
                      )
                    : const Column(
                        children: [
                          Icon(
                            Icons.support_agent_outlined,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 30,
                          ),
                          Text(
                            'Advisor',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      )),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                icon: pageIndex == 3
                    ? const Column(
                        children: [
                          Icon(
                            Icons.group,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 40,
                          ),
                        ],
                      )
                    : const Column(
                        children: [
                          Icon(
                            Icons.group_outlined,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 30,
                          ),
                          Text(
                            'Buddy',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      )),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 4;
                  });
                },
                icon: pageIndex == 4
                    ? const Column(
                        children: [
                          Icon(
                            Icons.settings,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 40,
                          ),
                        ],
                      )
                    : const Column(
                        children: [
                          Icon(
                            Icons.settings_outlined,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 30,
                          ),
                          Text('Settings', style: TextStyle(fontSize: 10))
                        ],
                      )),
          ],
        ));
  }
}
