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
          if (widget.childColorIndex == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          childProfile(child: child)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: const Color(0xff71CBCA),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(child!.childProfileImg),
                    ),
                    title: Text(child.childName),
                  ),
                ),
              ),
            );
          } else if (widget.childColorIndex == 1) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          childProfile(child: child)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: const Color(0xffF29180),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(child!.childProfileImg),
                    ),
                    title: Text(child.childName),
                  ),
                ),
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          childProfile(child: child)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: const Color(0xff8290F0),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    title: Text(child!.childName),
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(child.childProfileImg),
                    ),
                  ),
                ),
              ),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
