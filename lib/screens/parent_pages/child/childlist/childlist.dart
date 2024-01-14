import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/screens/parent_pages/child/childlist/childtile.dart';

class childList extends StatefulWidget {
  const childList({super.key, required this.children});
  final List<childModel>? children;

  @override
  State<childList> createState() => _childListState();
}

class _childListState extends State<childList> {
  @override
  Widget build(BuildContext context) {
    if (widget.children!.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(50),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/background/nodatabg.png"),
                      fit: BoxFit.cover),
                ),
                child: Container()),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Oops! No children here...',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      );
      // return Container(
      //   height: 100,
      //   width: double.maxFinite,
      //   child: Column(
      //     children: <Widget>[
      //       Container(
      //         decoration: const BoxDecoration(
      //           image: DecorationImage(
      //               image: AssetImage("assets/background/nodatabg.png"),
      //               fit: BoxFit.cover),
      //         ),
      //         child: Text(''),
      //       ),
      //       const Text(
      //         'Oops! There is no child at the moment.'
      //       )
      //     ],
      //   ),
      // );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.children!.length,
        itemBuilder: (context, index) {
          return childTile(
            childDetail: widget.children![index],
            childColorIndex: (index % 3),
            childId: widget.children![index].childId,
          );
        },
      );
    }
  }
}
