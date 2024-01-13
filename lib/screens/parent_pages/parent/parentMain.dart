// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/screens/parent_pages/child/childlist/childlist.dart';

class parentMain extends StatefulWidget {
  const parentMain({super.key});

  @override
  State<parentMain> createState() => _parentMainState();
}

class _parentMainState extends State<parentMain> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    parentModel? parent = Provider.of<parentModel?>(context);
    if (parent == null) {
      return Container();
    } else {
      return StreamProvider<List<childModel>>.value(
        initialData: [],
        value: parentDatabase(parentId: parent.parentId).allChildData,
        child: Stack(children: <Widget>[
          Container(
            height: 600,
            width: double.maxFinite,
            child: const Positioned.fill(
              child: Image(
                image: AssetImage('assets/background/homebg.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Welcome, ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${parent.parentFirstName}!',
                                style: const TextStyle(fontSize: 35),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(parent.parentProfileImg),
                          radius: 40.0,
                          backgroundColor: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Last login: ${_auth.getUserLastSignedIn()}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.thumb_up,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('Recent Activities',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0)),
                        Expanded(
                          child: Container(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    // ignore: sized_box_for_whitespace
                    Container(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                              width: 250,
                              margin: const EdgeInsets.only(right: 5.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/background/activitybg-childedu.png"),
                                      fit: BoxFit.cover),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: const Column(
                                children: <Widget>[
                                  Text(
                                    'Checkout Education Module Now!',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Feel free to explore our exclusive education module!',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                          Container(
                              width: 250,
                              margin: const EdgeInsets.only(right: 5.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/background/activitybg-childhealth.png"),
                                      fit: BoxFit.cover),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: const Column(
                                children: <Widget>[
                                  Text(
                                    'Health Module Is Available!',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Special module to monitor your child\'s health. Now available!',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                          Container(
                              width: 250,
                              margin: const EdgeInsets.only(right: 5.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/background/activitybg-buddy.png"),
                                      fit: BoxFit.cover),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: const Column(
                                children: <Widget>[
                                  Text(
                                    'Register to Buddy Now!',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Connect with community full of lovely and passionate parents!',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.face,
                          size: 35,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Your Child',
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        Expanded(child: Container()),
                        StreamBuilder<List<childModel>>(
                            stream: parentDatabase(parentId: parent.parentId)
                                .allChildData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: [
                                    Text(
                                      'No.of Children: ${snapshot.data?.length}',
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 13),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            })
                      ],
                    ),
                    const childList(),
                    const SizedBox(
                      height: 30.0,
                    ),
                  ]),
            ),
          ),
        ]),
      );
    }
  }
}
