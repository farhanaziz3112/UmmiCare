import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/advisorModel.dart';
import 'package:ummicare/models/buddyModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/screens/charts/noOfChildsOverallStatus.dart';
import 'package:ummicare/screens/parent_pages/advisor/chat.dart';
import 'package:ummicare/screens/parent_pages/child/childlist/childlist.dart';
import 'package:ummicare/screens/parent_pages/child/registerChild.dart';
import 'package:ummicare/services/buddyDatabase.dart';
import 'package:ummicare/services/advisorDatabase.dart';
import 'package:ummicare/services/chatDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/shared/constant.dart';

import '../../../models/childModel.dart';

class childMain extends StatefulWidget {
  const childMain({super.key});

  @override
  State<childMain> createState() => _childMainState();
}

class _childMainState extends State<childMain> {
  @override
  Widget build(BuildContext context) {
    parentModel? parent = Provider.of<parentModel?>(context);
    final parentId = parent!.parentId;

    return Column(
      children: [
        Container(
            height: 400,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background/childmainbg.png"),
                  fit: BoxFit.cover),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(flex: 3, child: Container()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.face,
                      size: 35,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Your Child",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Manage your child\'s profile, education and health!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(flex: 1, child: Container()),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      const Text(
                        'Registered Children',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xff8290F0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        registerChild(parentId: parentId)));
                          }),
                    ],
                  ),
                )
              ],
            )),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: <Widget>[
                StreamBuilder<List<childModel>>(
                    stream:
                        parentDatabase(parentId: parent.parentId).allChildData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<childModel>? childs = snapshot.data;
                        if (childs!.isEmpty) {
                          return Container(
                              padding: const EdgeInsets.all(50),
                              alignment: Alignment.center,
                              child: noData('Oops! No children here...'));
                        } else {
                          int great = 0;
                          int normal = 0;
                          int needsattention = 0;
                          for (int i = 0; i < childs.length; i++) {
                            if (childs[i].overallStatus == 'great') {
                              great = great + 1;
                            } else if (childs[i].overallStatus == 'normal') {
                              normal = normal + 1;
                            } else {
                              needsattention = needsattention + 1;
                            }
                          }
                          return Column(
                            children: [
                              childList(children: childs),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        const Text(
                                          'Total Children',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Container(
                                            height: 1.0,
                                            width: double.infinity,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        Text(
                                          childs.length.toString(),
                                          style: const TextStyle(fontSize: 30),
                                        )
                                      ],
                                    ),
                                  )),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/background/childstatusbg.png"),
                                          fit: BoxFit.cover),
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Great',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.green[800],
                                              radius: 5,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Container(
                                            height: 1.0,
                                            width: double.infinity,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        Text(
                                          great.toString(),
                                          style: const TextStyle(fontSize: 30),
                                        )
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/background/childstatusbg2.png"),
                                          fit: BoxFit.cover),
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                         Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Normal',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.yellow[600],
                                              radius: 5,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Container(
                                            height: 1.0,
                                            width: double.infinity,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        Text(
                                          normal.toString(),
                                          style: const TextStyle(fontSize: 30),
                                        )
                                      ],
                                    ),
                                  )),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/background/childstatusbg3.png"),
                                          fit: BoxFit.cover),
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Needs Attention',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.red[800],
                                              radius: 5,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Container(
                                            height: 1.0,
                                            width: double.infinity,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        Text(
                                          needsattention.toString(),
                                          style: const TextStyle(fontSize: 30),
                                        )
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                              const SizedBox(height: 50,),
                            ],
                          );
                        }
                      } else {
                        return Container();
                      }
                    }),
                const SizedBox(height: 100),
              ],
            )),
      ],
    );
  }
}
