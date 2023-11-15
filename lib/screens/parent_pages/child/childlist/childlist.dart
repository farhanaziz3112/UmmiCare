import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/screens/parent_pages/child/childlist/childtile.dart';

class childList extends StatefulWidget {
  const childList({super.key});

  @override
  State<childList> createState() => _childListState();
}

class _childListState extends State<childList> {
  @override
  Widget build(BuildContext context) {
    final childDetails = Provider.of<List<childModel>>(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: childDetails.length,
      itemBuilder: (context, index) {
        return childTile(
          childDetail: childDetails[index],
          childColorIndex: (index % 3),
          childId: childDetails[index].childId,
        );
      },
    );
  }
}

