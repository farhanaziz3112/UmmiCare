import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/advisormodel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/screens/parent_pages/child/advisory/chat.dart';
import 'package:ummicare/screens/parent_pages/child/childlist/childlist.dart';
import 'package:ummicare/screens/parent_pages/child/registerChild.dart';
import 'package:ummicare/services/advisorDatabase.dart';
import 'package:ummicare/services/chatDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';

import '../../../models/childmodel.dart';

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

    return StreamProvider<List<ChildModel>>.value(
      initialData: [],
      value: parentDatabase(parentId: parentId).allChildData,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "Your Child",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff8290F0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: const Text(
                            'Add New Child',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        registerChild(parentId: parentId)));
                          })
                    ]),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                child: const childList(),
              ),
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Advisor",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 10.0,
              ),
              StreamBuilder<parentModel>(
                stream: parentDatabase(parentId: parent.parentId).parentData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    parentModel? parent = snapshot.data;
                    if (parent!.advisorId == '') {
                      return Container(
                        child: Column(
                          children: [
                            const Text(
                              'Your account does not has an Advisor at the moment. Click on the button below to activate Advisor.',
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            StreamBuilder<List<advisorModel>>(
                              stream:
                                  advisorDatabase(advisorId: '').allAdvisorData,
                              builder: (context, snapshot) {
                                List<advisorModel>? advisorList = snapshot.data;
                                var temp =
                                    int.parse(advisorList![0].noOfParents);
                                advisorModel assignedAdvisor = advisorList[0];
                                for (var i = 0; i < advisorList.length; i++) {
                                  if (int.parse(advisorList[i].noOfParents) <
                                      temp) {
                                    temp =
                                        int.parse(advisorList[i].noOfParents);
                                    assignedAdvisor = advisorList[i];
                                  }
                                }
                                return ElevatedButton(
                                  onPressed: () {
                                    advisorDatabase(
                                            advisorId:
                                                assignedAdvisor.advisorId)
                                        .addParent({
                                      'parentId': parent.parentId,
                                      'parentFullName': parent.parentFullName,
                                      'parentFirstName': parent.parentFirstName,
                                      'parentLastName': parent.parentLastName,
                                      'parentEmail': parent.parentEmail,
                                      'parentPhoneNumber':
                                          parent.parentPhoneNumber,
                                      'parentProfileImg':
                                          parent.parentProfileImg,
                                      'advisorId': assignedAdvisor.advisorId
                                    }, assignedAdvisor, parentId);
                                    parentDatabase(parentId: parentId)
                                        .updateParentData(
                                            parentId,
                                            parent.parentFullName,
                                            parent.parentFirstName,
                                            parent.parentLastName,
                                            parent.parentEmail,
                                            parent.parentPhoneNumber,
                                            parent.parentProfileImg,
                                            assignedAdvisor.advisorId);
                                    chatDatabase(
                                            chatId:
                                                "${assignedAdvisor.advisorId}${parent.parentId}")
                                        .updateChatData(
                                            assignedAdvisor.advisorId,
                                            parent.parentId);
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text(
                                                  'New Advisor Activation!'),
                                              content: const Text(
                                                'An advisor has been assigned to your account! Feel free to contact the advisor throught our chatting page.',
                                                textAlign: TextAlign.justify,
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: (() {
                                                    Navigator.of(context).pop();
                                                  }),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Text('OK'),
                                                  ),
                                                )
                                              ],
                                            ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff8290F0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: const Text(
                                    'Activate Advisor',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return StreamBuilder<advisorModel>(
                        stream: advisorDatabase(advisorId: parent.advisorId)
                            .advisorData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            advisorModel? advisor = snapshot.data;
                            return Column(
                              children: <Widget>[
                                Card(
                                  margin: const EdgeInsets.fromLTRB(
                                      0.0, 10.0, 0.0, 0.0),
                                  color: const Color(0xffF29180),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 5.0),
                                    leading: CircleAvatar(
                                      radius: 40.0,
                                      backgroundColor: Colors.grey[300],
                                      backgroundImage: NetworkImage(
                                          advisor!.advisorProfileImg),
                                    ),
                                    title: Text(advisor.advisorFullName),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          advisor.advisorEmail,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          advisor.advisorPhoneNumber,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => chat(
                                                    advisorId:
                                                        advisor.advisorId,
                                                    parentId: parentId),
                                              ));
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Color(0xff71CBCA),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: const Column(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.forum,
                                                      size: 50.0,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Chat',
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      'Chat anytime, anywhere with your advisor!',
                                                      style: TextStyle(
                                                          fontSize: 10.0,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Color(0xff8290F0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15.0, 5.0, 15.0, 15.0),
                                                child: const Column(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.settings,
                                                      size: 50.0,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Settings',
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      'System settings for advisor and parent',
                                                      style: TextStyle(
                                                          fontSize: 10.0,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          )),
    );
  }
}
