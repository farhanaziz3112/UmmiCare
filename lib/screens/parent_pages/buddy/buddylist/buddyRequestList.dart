import 'package:flutter/material.dart';
import 'package:ummicare/models/buddyModel.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddylist/buddyRequestTile.dart';
import 'package:ummicare/shared/constant.dart';

class buddyRequestList extends StatefulWidget {
  const buddyRequestList(
      {super.key, required this.ownerId, required this.requestList});
  final String ownerId;
  final List<friendRequestModel>? requestList;

  @override
  State<buddyRequestList> createState() => _buddyRequestListState();
}

class _buddyRequestListState extends State<buddyRequestList> {
  @override
  Widget build(BuildContext context) {
    if (widget.requestList!.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: noData('Nothing here...')
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.requestList!.length,
        itemBuilder: ((context, index) {
          return buddyRequestTile(ownerId: widget.ownerId, profileId: widget.requestList![index].senderId,);
        }),
      );
    }
  }
}
