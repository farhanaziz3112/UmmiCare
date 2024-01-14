import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/storage.dart';
import 'package:ummicare/services/studentAttendanceDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class attendanceMain extends StatefulWidget {
  const attendanceMain(
      {super.key, required this.academicCalendarId, required this.studentId});
  final String academicCalendarId;
  final String studentId;

  @override
  State<attendanceMain> createState() => _attendanceMainState();
}

class _attendanceMainState extends State<attendanceMain> {
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String month = 'January';
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<academicCalendarModel>(
        stream: academicCalendarDatabase()
            .academicCalendarData(widget.academicCalendarId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            academicCalendarModel? academicCalendar = snapshot.data;
            return StreamBuilder<studentModel>(
                stream: studentDatabase().studentData(widget.studentId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    studentModel? student = snapshot.data;
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text(
                          "Attendance",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        elevation: 3,
                        iconTheme: const IconThemeData(color: Colors.black),
                        centerTitle: true,
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                      ),
                      body: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 30.0),
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              const Row(
                                children: [
                                  Icon(
                                    Icons.edit_calendar,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Attendance Leave',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.black),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xff8290F0),
                                                fixedSize: const Size(
                                                    double.maxFinite, 50),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                              ),
                                              child: const Text(
                                                'Apply Leave',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.0),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      final _formKey =
                                                          GlobalKey<
                                                              FormState>();

                                                      DateTime _leaveDate =
                                                          DateTime.now().add(
                                                              const Duration(
                                                                  days: 1));
                                                      String _reason = '';
                                                      String
                                                          _leaveProofImgLink =
                                                          '';
                                                      String
                                                          _leaveProofImgPath =
                                                          '';

                                                      return Form(
                                                        key: _formKey,
                                                        child: StatefulBuilder(
                                                          builder: (stfContext,
                                                              stfSetState) {
                                                            return AlertDialog(
                                                              scrollable: true,
                                                              title:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10.0),
                                                                child: Text(
                                                                    'Apply Leave'),
                                                              ),
                                                              content: SizedBox(
                                                                width: 500,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          10.0),
                                                                  child: Column(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 20.0),
                                                                          child:
                                                                              const Text(
                                                                            'Reason',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5.0,
                                                                        ),
                                                                        TextFormField(
                                                                          initialValue:
                                                                              _reason,
                                                                          maxLines:
                                                                              5,
                                                                          minLines:
                                                                              1,
                                                                          maxLength:
                                                                              200,
                                                                          decoration:
                                                                              textInputDecoration.copyWith(hintText: 'Leave reason'),
                                                                          validator: (value) => value == ''
                                                                              ? 'Please enter leave reason'
                                                                              : null,
                                                                          onChanged: (value) =>
                                                                              setState(() => _reason = value),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              20.0,
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 20.0),
                                                                          child:
                                                                              const Text(
                                                                            'Leave Date',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              20.0,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: <Widget>[
                                                                            Column(
                                                                              children: [
                                                                                const Text(
                                                                                  'Day',
                                                                                  style: TextStyle(color: Colors.grey),
                                                                                ),
                                                                                const SizedBox(height: 5),
                                                                                Text(
                                                                                  _leaveDate.day.toString(),
                                                                                  style: const TextStyle(fontSize: 20.0),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(width: 5),
                                                                            const Text(
                                                                              ' / ',
                                                                              style: TextStyle(fontSize: 20),
                                                                            ),
                                                                            const SizedBox(width: 5),
                                                                            Column(
                                                                              children: [
                                                                                const Text(
                                                                                  'Month',
                                                                                  style: TextStyle(color: Colors.grey),
                                                                                ),
                                                                                const SizedBox(height: 5),
                                                                                Text(
                                                                                  _leaveDate.month.toString(),
                                                                                  style: const TextStyle(fontSize: 20.0),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(width: 5),
                                                                            const Text(
                                                                              ' / ',
                                                                              style: TextStyle(fontSize: 20),
                                                                            ),
                                                                            const SizedBox(width: 5),
                                                                            Column(
                                                                              children: [
                                                                                const Text(
                                                                                  'Year',
                                                                                  style: TextStyle(color: Colors.grey),
                                                                                ),
                                                                                const SizedBox(height: 5),
                                                                                Text(
                                                                                  _leaveDate.year.toString(),
                                                                                  style: const TextStyle(fontSize: 20.0),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(width: 10),
                                                                            IconButton(
                                                                              icon: Icon(
                                                                                Icons.edit,
                                                                                color: Colors.grey[800],
                                                                              ),
                                                                              onPressed: () {
                                                                                showDatePicker(
                                                                                  context: context,
                                                                                  initialDate: _leaveDate,
                                                                                  firstDate: _leaveDate,
                                                                                  lastDate: DateTime.now().add(const Duration(days: 30)),
                                                                                ).then((date) {
                                                                                  stfSetState(() {
                                                                                    _leaveDate = date!;
                                                                                  });
                                                                                });
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              20.0,
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 20.0),
                                                                          child:
                                                                              const Text(
                                                                            'Supporting Image',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5.0,
                                                                        ),
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              color: const Color.fromARGB(255, 255, 255, 255),
                                                                              borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                                              border: Border.all(color: Colors.grey, width: 1),
                                                                              boxShadow: const [
                                                                                BoxShadow(
                                                                                  color: Colors.grey,
                                                                                  spreadRadius: 0,
                                                                                  blurRadius: 1,
                                                                                )
                                                                              ]),
                                                                          child:
                                                                              Row(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                flex: 5,
                                                                                child: Container(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                                  child: Text(
                                                                                    _leaveProofImgPath,
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
                                                                                    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
                                                                                    if (pickedFile != null) {
                                                                                      stfSetState(() {
                                                                                        _leaveProofImgPath = pickedFile.path.toString();
                                                                                      });
                                                                                      _leaveProofImgLink = await StorageService().uploadLeaveProofImg(pickedFile);
                                                                                    }
                                                                                  },
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ]),
                                                                ),
                                                              ),
                                                              actions: [
                                                                ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        const Color(
                                                                            0xffF29180),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: const Text(
                                                                      "Cancel",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                ),
                                                                ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        const Color(
                                                                            0xff8290F0),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    studentAttendanceDatabase().createStudentLeaveData(
                                                                        student!
                                                                            .studentId,
                                                                        _reason,
                                                                        _leaveDate
                                                                            .millisecondsSinceEpoch
                                                                            .toString(),
                                                                        _leaveProofImgLink,
                                                                        'pending');
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();

                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            const SnackBar(
                                                                      content: Text(
                                                                          'Attendance Leave successfully submitted!'),
                                                                    ));
                                                                  },
                                                                  child: const Text(
                                                                      "Confirm",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    });
                                              })),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xffF29180),
                                              fixedSize: const Size(
                                                  double.maxFinite, 50),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                            child: const Text(
                                              'View Leave Record',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0),
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      scrollable: true,
                                                      title: const Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                            'Leave Record'),
                                                      ),
                                                      content: SizedBox(
                                                        height:
                                                            double.maxFinite,
                                                        width: double.maxFinite,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: StreamBuilder<
                                                              List<
                                                                  studentLeaveModel>>(
                                                            stream: studentAttendanceDatabase()
                                                                .allStudentLeaveWithStudentId(
                                                                    student!
                                                                        .studentId),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                if (snapshot
                                                                    .data!
                                                                    .isEmpty) {
                                                                  return const Text(
                                                                    'The list is empty.',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  );
                                                                } else {
                                                                  List<studentLeaveModel>?
                                                                      leaves =
                                                                      snapshot
                                                                          .data;
                                                                  return ListView
                                                                      .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount:
                                                                        leaves!
                                                                            .length,
                                                                    itemBuilder:
                                                                        ((context,
                                                                            index) {
                                                                      return Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                10),
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 10,
                                                                              vertical: 20),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                const BorderRadius.all(Radius.circular(1)),
                                                                            border:
                                                                                Border.all(color: Colors.grey),
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Colors.grey.withOpacity(0.5),
                                                                                spreadRadius: 1,
                                                                                blurRadius: 1,
                                                                                offset: const Offset(0, 0), // changes position of shadow
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                flex: 2,
                                                                                child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                                                                                  child: Text(
                                                                                    convertTimeToDateWithStringMonth(leaves[index].leaveDate),
                                                                                    textAlign: TextAlign.center,
                                                                                    style: const TextStyle(color: Colors.black, fontSize: 12),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                flex: 1,
                                                                                child: Container(),
                                                                              ),
                                                                              Expanded(
                                                                                flex: 2,
                                                                                child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                                                                                  child: Text(
                                                                                    leaves[index].reason,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 12),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                flex: 1,
                                                                                child: Container(),
                                                                              ),
                                                                              leaves[index].status == 'pending'
                                                                                  ? Expanded(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color: Colors.yellow[500],
                                                                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                          ),
                                                                                          padding: const EdgeInsets.all(5),
                                                                                          child: const Text(
                                                                                            'Pending',
                                                                                            style: TextStyle(color: Colors.black, fontSize: 12),
                                                                                          )),
                                                                                    )
                                                                                  : leaves[index].status == 'approved'
                                                                                      ? Expanded(
                                                                                          flex: 2,
                                                                                          child: Container(
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.green[500],
                                                                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                              ),
                                                                                              padding: const EdgeInsets.all(5),
                                                                                              child: const Text(
                                                                                                'Approved',
                                                                                                style: TextStyle(color: Colors.black, fontSize: 12),
                                                                                              )),
                                                                                        )
                                                                                      : Expanded(
                                                                                          flex: 2,
                                                                                          child: Container(
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.red[500],
                                                                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                              ),
                                                                                              padding: const EdgeInsets.all(5),
                                                                                              child: const Text(
                                                                                                'Rejected',
                                                                                                style: TextStyle(color: Colors.black, fontSize: 12),
                                                                                              )),
                                                                                        )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                                  );
                                                                }
                                                              } else {
                                                                return Container(
                                                                  color: Colors
                                                                      .grey,
                                                                  child:
                                                                      const SizedBox(
                                                                    height: 100,
                                                                    width: 100,
                                                                    child: Text(
                                                                      'The list is empty.',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            }),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.fact_check,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'View Attendance Record',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.black),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: const Text(
                                        'Month : ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: DropdownButton(
                                        underline: const SizedBox(),
                                        dropdownColor: Colors.grey[100],
                                        elevation: 5,
                                        value: month,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: months.map((String item) {
                                          return DropdownMenuItem(
                                              value: item, child: Text(item));
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            month = value as String;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff71CBCA),
                                    fixedSize: const Size(180, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: const Text(
                                    'View Attendance',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            scrollable: true,
                                            title: const Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text('Attendance Record'),
                                            ),
                                            content: SizedBox(
                                              height: 400,
                                              width: double.maxFinite,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: StreamBuilder<
                                                        List<
                                                            studentAttendanceModel>>(
                                                    stream: studentAttendanceDatabase()
                                                        .allStudentAttendanceWithStudentIdAndMonth(
                                                            student!.studentId,
                                                            (months.indexOf(
                                                                        month) +
                                                                    1)
                                                                .toString()),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        if (snapshot
                                                            .data!.isEmpty) {
                                                          return const Text(
                                                            'The list is empty.',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          );
                                                        } else {
                                                          List<studentAttendanceModel>?
                                                              attendance =
                                                              snapshot.data;
                                                          return ListView
                                                              .builder(
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                attendance!
                                                                    .length,
                                                            itemBuilder:
                                                                ((context,
                                                                    index) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          5,
                                                                      vertical:
                                                                          10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                            Radius.circular(1)),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.5),
                                                                        spreadRadius:
                                                                            1,
                                                                        blurRadius:
                                                                            1,
                                                                        offset: const Offset(
                                                                            0,
                                                                            0), // changes position of shadow
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: <Widget>[
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          constraints: const BoxConstraints(
                                                                              minWidth: 100,
                                                                              maxWidth: 200),
                                                                          child:
                                                                              Text(
                                                                            '${attendance[index].attendanceDateDay} ${monthToString(int.parse(attendance[index].attendanceDateMonth))} ${attendance[index].attendanceDateYear}',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                const TextStyle(color: Colors.black, fontSize: 12),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(),
                                                                      ),
                                                                      attendance[index].attendanceStatus ==
                                                                              'present'
                                                                          ? Expanded(
                                                                              flex: 2,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.green[500],
                                                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                  ),
                                                                                  alignment: Alignment.center,
                                                                                  padding: const EdgeInsets.all(5),
                                                                                  child: const Text(
                                                                                    'Present',
                                                                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                                                                  )),
                                                                            )
                                                                          : Expanded(
                                                                              flex: 2,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.red[500],
                                                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                  ),
                                                                                  alignment: Alignment.center,
                                                                                  padding: const EdgeInsets.all(5),
                                                                                  child: const Text(
                                                                                    'Absent',
                                                                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                                                                  )),
                                                                            )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          );
                                                        }
                                                      } else {
                                                        return const Center(
                                                          child: Text(
                                                            'The list is empty.',
                                                          ),
                                                        );
                                                      }
                                                    }),
                                              ),
                                            ),
                                          );
                                        });
                                  })
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
        });
  }
}
