// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/activityModel.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/services/activityDatabase.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/screens/parent_pages/child/childlist/childlist.dart';
import 'package:ummicare/shared/function.dart';

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
      return Column(children: <Widget>[
        Container(
            height: 400,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background/homebg.png"),
                  fit: BoxFit.cover),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(flex: 2, child: Container()),
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
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.black,
                              spreadRadius: 1)
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(parent.parentProfileImg),
                        radius: 40.0,
                        backgroundColor: Colors.grey,
                      ),
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
                  textAlign: TextAlign.start,
                ),
                Expanded(flex: 1, child: Container()),
              ],
            )),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      const Icon(
                        Icons.thumb_up,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('Recent Activities',
                          style:
                              TextStyle(color: Colors.black, fontSize: 17.0)),
                      Expanded(
                        child: Container(),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  StreamBuilder<List<activityModel>>(
                      stream: activityDatabase()
                          .allactivityDataWithParentId(parent.parentId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<activityModel>? activities = snapshot.data;
                          activities!.sort(
                              (a, b) => b.createdAt.compareTo(a.createdAt));
                          return SizedBox(
                            height: 200,
                            width: double.maxFinite,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 250,
                                      childAspectRatio: 0.9,
                                      crossAxisSpacing: 70,
                                      mainAxisSpacing: 10),
                              itemCount: activities.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: const EdgeInsets.only(right: 5.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: activities[index].type ==
                                                    'advisor'
                                                ? const AssetImage(
                                                    "assets/background/activitybg-advisor.png")
                                                : activities[index].type ==
                                                    'child'
                                                ? const AssetImage(
                                                    "assets/background/activitybg-child.png")
                                                : activities[index].type ==
                                                        'education'
                                                    ? const AssetImage(
                                                        "assets/background/activitybg-childedu.png")
                                                    : activities[index].type ==
                                                            'health'
                                                        ? const AssetImage(
                                                            "assets/background/activitybg-childhealth.png")
                                                        : const AssetImage(
                                                            "assets/background/activitybg-buddy.png"),
                                            fit: BoxFit.cover),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          activities[index].activityTitle,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          activities[index].activityDescription,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Expanded(child: Container()),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            convertTimeToDateString(activities[index].createdAt),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey[200]
                                            ),
                                          ),
                                        )
                                      ],
                                    ));
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                  // Container(
                  //   height: 150,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: <Widget>[
                  //       Container(
                  //           width: 250,
                  //           margin: const EdgeInsets.only(right: 5.0),
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 10, vertical: 10),
                  //           decoration: const BoxDecoration(
                  //               image: DecorationImage(
                  //                   image: AssetImage(
                  //                       "assets/background/activitybg-childedu.png"),
                  //                   fit: BoxFit.cover),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(10.0))),
                  //           child: const Column(
                  //             children: <Widget>[
                  //               Text(
                  //                 'Checkout Education Module Now!',
                  //                 style: TextStyle(
                  //                     fontSize: 20,
                  //                     fontWeight: FontWeight.w700),
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Text(
                  //                 'Feel free to explore our exclusive education module!',
                  //                 style: TextStyle(color: Colors.white),
                  //               )
                  //             ],
                  //           )),
                  //       Container(
                  //           width: 250,
                  //           margin: const EdgeInsets.only(right: 5.0),
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 10, vertical: 10),
                  //           decoration: const BoxDecoration(
                  //               image: DecorationImage(
                  //                   image: AssetImage(
                  //                       "assets/background/activitybg-childhealth.png"),
                  //                   fit: BoxFit.cover),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(10.0))),
                  //           child: const Column(
                  //             children: <Widget>[
                  //               Text(
                  //                 'Health Module Is Available!',
                  //                 style: TextStyle(
                  //                     fontSize: 20,
                  //                     fontWeight: FontWeight.w700),
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Text(
                  //                 'Special module to monitor your child\'s health. Now available!',
                  //                 style: TextStyle(color: Colors.white),
                  //               )
                  //             ],
                  //           )),
                  //       Container(
                  //           width: 250,
                  //           margin: const EdgeInsets.only(right: 5.0),
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 10, vertical: 10),
                  //           decoration: const BoxDecoration(
                  //               image: DecorationImage(
                  //                   image: AssetImage(
                  //                       "assets/background/activitybg-buddy.png"),
                  //                   fit: BoxFit.cover),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(10.0))),
                  //           child: const Column(
                  //             children: <Widget>[
                  //               Text(
                  //                 'Register to Buddy Now!',
                  //                 style: TextStyle(
                  //                     fontSize: 20,
                  //                     fontWeight: FontWeight.w700),
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Text(
                  //                 'Connect with community full of lovely and passionate parents!',
                  //                 style: TextStyle(color: Colors.white),
                  //               )
                  //             ],
                  //           )),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.face,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Your Child',
                        style: TextStyle(color: Colors.black, fontSize: 17.0),
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
                                        color: Colors.grey[700], fontSize: 13),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          })
                    ],
                  ),
                  StreamBuilder<List<childModel>>(
                      stream: parentDatabase(parentId: parent.parentId)
                          .allChildData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return childList(
                            children: snapshot.data,
                          );
                        } else {
                          return Container();
                        }
                      }),
                  const SizedBox(
                    height: 30.0,
                  ),
                ]),
          ),
        ),
      ]);
    }
  }
}
