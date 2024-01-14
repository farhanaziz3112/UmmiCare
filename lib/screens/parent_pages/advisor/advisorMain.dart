import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/advisorModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/screens/parent_pages/advisor/chat.dart';
import 'package:ummicare/screens/parent_pages/child/registerChild.dart';
import 'package:ummicare/services/advisorDatabase.dart';
import 'package:ummicare/services/chatDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';

class advisorMain extends StatefulWidget {
  const advisorMain({super.key});

  @override
  State<advisorMain> createState() => _advisorMainState();
}

class _advisorMainState extends State<advisorMain> {
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
                  image: AssetImage("assets/background/advisormainbg.png"),
                  fit: BoxFit.cover),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(flex: 1, child: Container()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.support_agent,
                      size: 35,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Advisor",
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
                  'Reach our advisor, anytime, anywhere!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 30,
                )
              ],
            )),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: <Widget>[
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
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
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
                                        'Your account does not have an Advisor at the moment. Click on the button below to activate Advisor.',
                                        textAlign: TextAlign.justify,
                                        softWrap: true,
                                        maxLines: 5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              StreamBuilder<List<advisorModel>>(
                                stream: advisorDatabase(advisorId: '')
                                    .allAdvisorData,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<advisorModel>? advisorList =
                                        snapshot.data;
                                    var temp =
                                        int.parse(advisorList![0].noOfParents);
                                    advisorModel assignedAdvisor =
                                        advisorList[0];
                                    for (var i = 0;
                                        i < advisorList.length;
                                        i++) {
                                      if (int.parse(
                                              advisorList[i].noOfParents) <
                                          temp) {
                                        temp = int.parse(
                                            advisorList[i].noOfParents);
                                        assignedAdvisor = advisorList[i];
                                      }
                                    }
                                    return ElevatedButton(
                                      onPressed: () {
                                        String assignedDate = DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString();
                                        advisorDatabase(
                                                advisorId:
                                                    assignedAdvisor.advisorId)
                                            .addParent({
                                          'parentId': parent.parentId,
                                          'assignedDate': assignedDate
                                        }, assignedAdvisor, parentId);
                                        parentDatabase(parentId: parentId)
                                            .updateParentData(
                                                parentId,
                                                parent.parentCreatedDate,
                                                parent.parentFullName,
                                                parent.parentFirstName,
                                                parent.parentLastName,
                                                parent.parentEmail,
                                                parent.parentPhoneNumber,
                                                parent.parentProfileImg,
                                                assignedAdvisor.advisorId,
                                                parent.noOfChild);
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
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: (() {
                                                        Navigator.of(context)
                                                            .pop();
                                                      }),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: const Text('OK'),
                                                      ),
                                                    )
                                                  ],
                                                ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff8290F0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      child: const Text(
                                        'Activate Advisor',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
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
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 30.0,
                                          backgroundColor: Colors.grey[300],
                                          backgroundImage: NetworkImage(
                                              advisor!.advisorProfileImg),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Container(
                                            height: 1.0,
                                            width: double.infinity,
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              advisor.advisorFullName,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                        const SizedBox(height: 10),
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                const Icon(Icons.email),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  advisor.advisorEmail,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            )),
                                        const SizedBox(height: 5),
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                const Icon(Icons.phone),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  advisor.advisorPhoneNumber,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            )),
                                      ],
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
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
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
                const SizedBox(
                  height: 50.0,
                ),
              ],
            )),
      ],
    );
  }
}
