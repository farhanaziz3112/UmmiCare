import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/screens/parent_pages/child/health/BMI/BmiTile.dart';

class BmiList extends StatefulWidget {
  const BmiList({super.key, required this.bmi});
  final List<BmiModel>? bmi;

  @override
  State<BmiList> createState() => _BmiListState();
}

class _BmiListState extends State<BmiList> {
  @override
  Widget build(BuildContext context) {
    if (widget.bmi!.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: const Center(
          child: Text(
            'The list is empty.',
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.bmi!.length,
        itemBuilder: (context, index) {
          return BmiTile(
            healthId: widget.bmi![index].healthId,
            bmiId: widget.bmi![index].bmiId,
          );
        },
      );
    }
  }
}