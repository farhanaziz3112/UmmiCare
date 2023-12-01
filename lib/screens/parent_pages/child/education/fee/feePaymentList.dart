import 'package:flutter/material.dart';
import 'package:ummicare/models/feeModel.dart';
import 'package:ummicare/screens/parent_pages/child/education/fee/feePaymentTile.dart';

class feePaymentList extends StatefulWidget {
  const feePaymentList({super.key, required this.feeList});
  final List<feePaymentModel>? feeList;


  @override
  State<feePaymentList> createState() => _feePaymentListState();
}

class _feePaymentListState extends State<feePaymentList> {
  @override
  Widget build(BuildContext context) {
    if (widget.feeList!.isEmpty) {
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
        itemCount: widget.feeList!.length,
        itemBuilder: ((context, index) {
          return feePaymentTile(feePaymentId: widget.feeList![index].feePaymentId);
        }),
      );
    }
  }
}