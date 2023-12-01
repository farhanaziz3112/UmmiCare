import 'package:flutter/material.dart';
import 'package:ummicare/models/feeModel.dart';
import 'package:ummicare/screens/parent_pages/child/education/fee/pay.dart';
import 'package:ummicare/services/feeDatabase.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class feePaymentTile extends StatefulWidget {
  const feePaymentTile({super.key, required this.feePaymentId});
  final String feePaymentId;

  @override
  State<feePaymentTile> createState() => _feePaymentTileState();
}

class _feePaymentTileState extends State<feePaymentTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<feePaymentModel>(
        stream: feeDatabase().feePaymentData(widget.feePaymentId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            feePaymentModel? feePayment = snapshot.data;
            return StreamBuilder<feeModel>(
              stream: feeDatabase().feeData(feePayment!.feeId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  feeModel? fee = snapshot.data;
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Container(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            fee!.feeTitle,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Fee Amount',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('RM ${fee.feeAmount}'),
                          const SizedBox(height: 5),
                          const Text(
                            'Fee Description',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(fee.feeDescription),
                          const SizedBox(height: 5),
                          const Text(
                            'Fee Deadline',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(convertTimeToDateWithStringMonth(
                              fee.feeDeadline)),
                          const SizedBox(height: 10),
                          const Text(
                            'Fee Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          feePayment.feePaymentStatus == 'paid'
                              ? Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          padding: EdgeInsets.all(5),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(Icons.check, color: Colors.white,),
                                              Text('Paid', style: TextStyle(color: Colors.white),)
                                            ],
                                          )),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(),
                                    )
                                  ],
                                )
                              : feePayment.feePaymentStatus == 'pending'
                                  ? Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.yellow[300],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                              ),
                                              padding: EdgeInsets.all(5),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(Icons.schedule),
                                                  Text('Pending')
                                                ],
                                              )),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(),
                                        )
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red[300],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                              ),
                                              padding: EdgeInsets.all(5),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.cancel,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    'Unpaid',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              )),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(),
                                        )
                                      ],
                                    ),
                          const SizedBox(height: 20),
                          feePayment.feePaymentStatus == 'paid'
                              ? Container()
                              : feePayment.feePaymentStatus == 'pending'
                                  ? Container()
                                  : Container(
                                      alignment: Alignment.bottomCenter,
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.payment,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => pay(
                                                    paymentId: feePayment
                                                        .feePaymentId),
                                              ));
                                        },
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          fixedSize: const Size(200, 30),
                                          alignment: Alignment.center,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              side: BorderSide.none),
                                        ),
                                        label: const Text(
                                          'Confirm Payment',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Loading();
                }
              },
            );
          } else {
            return const Loading();
          }
        });
  }
}
