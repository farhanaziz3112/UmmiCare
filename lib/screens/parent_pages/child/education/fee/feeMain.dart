import 'package:flutter/material.dart';
import 'package:ummicare/models/feeModel.dart';
import 'package:ummicare/screens/parent_pages/child/education/fee/feePaymentList.dart';
import 'package:ummicare/services/feeDatabase.dart';
import 'package:ummicare/shared/loading.dart';

class feeMain extends StatefulWidget {
  const feeMain({super.key, required this.academicCalendarId, required this.studentId});
  final String academicCalendarId;
  final String studentId;

  @override
  State<feeMain> createState() => _feeMainState();
}

class _feeMainState extends State<feeMain> {
  int toggleView = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fee Payment",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 3,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: toggleView == 1
                          ? const Color(0xff8290F0)
                          : Colors.white,
                      fixedSize: const Size(200, 30),
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                          side: toggleView == 1
                              ? BorderSide.none
                              : const BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onPressed: () {
                      setState(() {
                        toggleView = 1;
                      });
                    },
                    child: Text(
                      'Paid',
                      style: TextStyle(
                          fontSize: 15,color: toggleView == 1 ? Colors.white : Colors.grey),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: toggleView == 2
                          ? const Color(0xff8290F0)
                          : Colors.white,
                      fixedSize: const Size(200, 30),
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                          side: toggleView == 2
                              ? BorderSide.none
                              : const BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onPressed: () {
                      setState(() {
                        toggleView = 2;
                      });
                    },
                    child: Text(
                      'Pending',
                      style: TextStyle(
                          fontSize: 15,color: toggleView == 2 ? Colors.white : Colors.grey),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: toggleView == 3
                          ? const Color(0xff8290F0)
                          : Colors.white,
                      fixedSize: const Size(200, 30),
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                          side: toggleView == 3
                              ? BorderSide.none
                              : const BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onPressed: () {
                      setState(() {
                        toggleView = 3;
                      });
                    },
                    child: Text(
                      'Unpaid',
                      style: TextStyle(
                          fontSize: 15, color: toggleView == 3 ? Colors.white : Colors.grey),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            toggleView == 1 ? 
            StreamBuilder<List<feePaymentModel>>(
              stream: feeDatabase().allFeePaymentDataWithAcademicCalendarIdStudentIdPaymentStatus(widget.academicCalendarId, 'paid', widget.studentId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return feePaymentList(feeList: snapshot.data);
                } else {
                  return Loading();
                }
              },
            ) : toggleView == 2 ?
            StreamBuilder<List<feePaymentModel>>(
              stream: feeDatabase().allFeePaymentDataWithAcademicCalendarIdStudentIdPaymentStatus(widget.academicCalendarId, 'pending', widget.studentId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return feePaymentList(feeList: snapshot.data);
                } else {
                  return Loading();
                }
              },
            ) : StreamBuilder<List<feePaymentModel>>(
              stream: feeDatabase().allFeePaymentDataWithAcademicCalendarIdStudentIdPaymentStatus(widget.academicCalendarId, 'unpaid', widget.studentId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return feePaymentList(feeList: snapshot.data);
                } else {
                  return Loading();
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
