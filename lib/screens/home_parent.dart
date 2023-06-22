import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddyMain.dart';
import 'package:ummicare/screens/parent_pages/child/childMain.dart';
import 'package:ummicare/screens/parent_pages/parent/parentMain.dart';
import 'package:ummicare/screens/settings/settingsMain.dart';
import 'package:ummicare/services/auth.dart';

import '../models/usermodel.dart';

class HomeParent extends StatefulWidget {
  const HomeParent({super.key});

  @override
  State<HomeParent> createState() => HomeParentState();
}

class HomeParentState extends State<HomeParent> {
  int pageIndex = 0;

  final pages = [
    const parentMain(),
    const childMain(),
    const BuddyMain(),
    const settingsMain(),
  ];

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
            icon: Icon(
              Icons.notifications,
              color: Colors.grey,
              size: 30.0,
            ),
            onPressed: () => {},
          ),
        ],
        title: Text(
          "UmmiCare",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(child: pages[pageIndex]),
      bottomNavigationBar: buildBottomBar(context),
    );
  }

  void changePage(int newPageIndex) {
    setState(() {
      pageIndex = newPageIndex;
    });
  }

  Container buildBottomBar(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
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
                  ? const Icon(
                      Icons.home,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 37,
                    )
                  : const Icon(
                      Icons.home_outlined,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 35,
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
                  ? const Icon(
                      Icons.face,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 37,
                    )
                  : const Icon(
                      Icons.face_outlined,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      Icons.group,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 37,
                    )
                  : const Icon(
                      Icons.group_outlined,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? const Icon(
                      Icons.settings,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 37,
                    )
                  : const Icon(
                      Icons.settings_outlined,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 35,
                    ),
            ),
          ],
        ));
  }
}
