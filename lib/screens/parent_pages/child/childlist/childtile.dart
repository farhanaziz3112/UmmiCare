import 'package:ummicare/models/childModel.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/screens/parent_pages/child/childprofile/childProfile.dart';
import 'package:ummicare/services/childDatabase.dart';

class childTile extends StatefulWidget {
  const childTile(
      {super.key,
      required this.childDetail,
      required this.childColorIndex,
      required this.childId});
  final childModel childDetail;
  final String childId;
  final int childColorIndex;

  @override
  State<childTile> createState() => _childTileState();
}

class _childTileState extends State<childTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<childModel>(
      stream: childDatabase(childId: widget.childId).childData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          childModel? child = snapshot.data;

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => childProfile(child: child)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Container(
                margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                decoration: BoxDecoration(
                    color: widget.childColorIndex == 0
                        ? const Color(0xff71CBCA)
                        : widget.childColorIndex == 1
                            ? const Color(0xffF29180)
                            : const Color(0xff8290F0),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(child!.childProfileImg),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          child.childName,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          child.childFirstname,
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[900]),
                        )
                      ],
                    )),
                    // Container(color: Colors.black38, height: 50, width: 1,),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // Column(
                    //   children: <Widget>[
                    //     const Text(
                    //       'Status',
                    //       style: TextStyle(fontSize: 13),
                    //     ),
                    //     CircleAvatar(
                    //       backgroundColor: Colors.green[800],
                    //       radius: 5,
                    //     ),
                    //     const Text(
                    //       'Normal',
                    //       style: TextStyle(fontSize: 10),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
                // child: ListTile(
                //   contentPadding: const EdgeInsets.symmetric(
                //       horizontal: 10.0, vertical: 5.0),
                //   leading: CircleAvatar(
                //     radius: 25.0,
                //     backgroundColor: Colors.grey[300],
                //     backgroundImage: NetworkImage(child!.childProfileImg),
                //   ),
                //   title: Text(child.childName),
                // ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
