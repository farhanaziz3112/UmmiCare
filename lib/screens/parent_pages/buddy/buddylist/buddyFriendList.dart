import 'package:flutter/material.dart';
import 'package:ummicare/models/buddyModel.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddylist/buddyFriendTile.dart';
import 'package:ummicare/shared/constant.dart';

class buddyFriendList extends StatefulWidget {
  const buddyFriendList(
      {super.key, required this.profileList, required this.userId});
  final List<friendModel>? profileList;
  final String userId;

  @override
  State<buddyFriendList> createState() => _buddyFriendListState();
}

class _buddyFriendListState extends State<buddyFriendList> {
  @override
  Widget build(BuildContext context) {
    if (widget.profileList!.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: noData('Nothing here..')
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.profileList!.length,
        itemBuilder: ((context, index) {
          return buddyFriendTile(
              profileId: widget.profileList![index].friendModelId,
              userId: widget.userId);
        }),
      );
    }
  }
}
