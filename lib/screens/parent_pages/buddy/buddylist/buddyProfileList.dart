import 'package:flutter/material.dart';
import 'package:ummicare/models/buddyModel.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddylist/buddyProfileTile.dart';
import 'package:ummicare/shared/constant.dart';

class buddyProfileList extends StatefulWidget {
  const buddyProfileList(
      {super.key, required this.profileList, required this.userId});
  final List<buddyProfileModel>? profileList;
  final String userId;

  @override
  State<buddyProfileList> createState() => _buddyProfileListState();
}

class _buddyProfileListState extends State<buddyProfileList> {
  @override
  Widget build(BuildContext context) {
    if (widget.profileList!.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: noData('Nothing here...')
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.profileList!.length,
        itemBuilder: ((context, index) {
          return buddyProfileTile(
              profile: widget.profileList![index], userId: widget.userId);
        }),
      );
    }
  }
}
