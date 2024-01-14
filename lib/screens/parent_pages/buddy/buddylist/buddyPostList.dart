import 'package:flutter/material.dart';
import 'package:ummicare/models/buddyModel.dart';
import 'package:ummicare/screens/parent_pages/buddy/buddylist/buddyPostTile.dart';
import 'package:ummicare/shared/constant.dart';

class buddyPostlist extends StatefulWidget {
  const buddyPostlist({super.key, required this.posts});
  final List<buddyPostModel>? posts;

  @override
  State<buddyPostlist> createState() => _buddyPostListState();
}

class _buddyPostListState extends State<buddyPostlist> {
  @override
  Widget build(BuildContext context) {
    if (widget.posts!.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: noData('There is no post at the moment')
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.posts!.length,
        itemBuilder: ((context, index) {
          return buddyPostTile(
              buddyPostId: widget.posts![index].buddyPostId);
        }),
      );
    }
  }
}
