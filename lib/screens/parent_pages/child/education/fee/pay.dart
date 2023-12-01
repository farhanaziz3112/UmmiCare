import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/feeModel.dart';
import 'package:ummicare/services/feeDatabase.dart';
import 'package:ummicare/services/storage.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class pay extends StatefulWidget {
  const pay({super.key, required this.paymentId});
  final String paymentId;

  @override
  State<pay> createState() => _payState();
}

class _payState extends State<pay> {
  final _formKey = GlobalKey<FormState>();

  String paymentAmount = '';
  String paymentProofImg = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<feePaymentModel>(
      stream: feeDatabase().feePaymentData(widget.paymentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          feePaymentModel? feePayment = snapshot.data;
          return StreamBuilder<feeModel>(
              stream: feeDatabase().feeData(feePayment!.feeId),
              builder: (context, snapshot) {
                feeModel? fee = snapshot.data;
                if (snapshot.hasData) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text(
                        "Confirm Payment",
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 30),
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 25),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 0,
                                      blurRadius: 1,
                                    )
                                  ]),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      fee!.feeTitle,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Fee Amount',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('RM ${fee.feeAmount}'),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Fee Description',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(fee.feeDescription),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Fee Deadline',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(convertTimeToDateWithStringMonth(
                                        fee.feeDeadline)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: const Text(
                                'Amount Paid',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextFormField(
                              initialValue: paymentAmount,
                              decoration: textInputDecoration.copyWith(
                                  hintText: fee.feeAmount),
                              validator: (value) => value == ''
                                  ? 'Please enter amount paid'
                                  : null,
                              onChanged: (value) =>
                                  setState(() => paymentAmount = value),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: const Text(
                                'Payment Proof',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 0,
                                      blurRadius: 1,
                                    )
                                  ]),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        paymentProofImg,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.photo_library,
                                        color: Colors.black,
                                      ),
                                      onPressed: () async {
                                        ImagePicker imagePicker = ImagePicker();
                                        XFile? pickedFile =
                                            await imagePicker.pickImage(
                                                source: ImageSource.gallery);
                                        if (pickedFile != null) {
                                          paymentProofImg = pickedFile.path.toString();
                                          await StorageService()
                                              .uploadPaymentProofImg(
                                                  feePayment, pickedFile);
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff8290F0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              child: const Text(
                                'Confirm Payment',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await feeDatabase().updateFeePaymentData(
                                      feePayment.feePaymentId,
                                      feePayment.feeId,
                                      feePayment.studentId,
                                      feePayment.academicCalendarId,
                                      paymentAmount,
                                      'pending',
                                      DateTime.now().millisecondsSinceEpoch.toString(),
                                      feePayment.feePaymentProofImg);
                                  Navigator.pop(context);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Loading();
                }
              });
        } else {
          return const Loading();
        }
      },
    );
  }
}
