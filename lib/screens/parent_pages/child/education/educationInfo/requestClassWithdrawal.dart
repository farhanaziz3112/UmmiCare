import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/storage.dart';
import 'package:ummicare/shared/constant.dart';

class requestClassWithdrawal extends StatefulWidget {
  const requestClassWithdrawal(
      {super.key, required this.academicCalendarId, required this.studentId});
  final String academicCalendarId;
  final String studentId;

  @override
  State<requestClassWithdrawal> createState() => _requestClassWithdrawalState();
}

class _requestClassWithdrawalState extends State<requestClassWithdrawal> {
  final _formKey = GlobalKey<FormState>();

  String reason = '';
  String supportingImage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Request Class Withdrawal",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<academicCalendarModel>(
            stream: academicCalendarDatabase()
                .academicCalendarData(widget.academicCalendarId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                academicCalendarModel? academicCalendar = snapshot.data;
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 30.0),
                  alignment: Alignment.center,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Insert your reason for withdrawal:',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Withdrawal Reason',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          initialValue: reason,
                          maxLines: 5,
                          minLines: 1,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Withdrawal reason'),
                          validator: (value) =>
                              value == '' ? 'Please enter your reason' : null,
                          onChanged: (value) => setState(() => reason = value),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Supporting Image',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              border: Border.all(color: Colors.grey, width: 1),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    supportingImage,
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
                                    XFile? pickedFile = await imagePicker
                                        .pickImage(source: ImageSource.gallery);
                                    if (pickedFile != null) {
                                      await StorageService()
                                          .uploadWithdrawalSupportingImage(
                                              pickedFile)
                                          .then((value) {
                                        setState(() {
                                          supportingImage = value;
                                        });
                                      });
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff8290F0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              String createdDate = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              academicCalendarDatabase()
                                  .createWithdrawalRequestData(
                                      academicCalendar!.academicCalendarId,
                                      academicCalendar.classId,
                                      academicCalendar.schoolId,
                                      academicCalendar.teacherId,
                                      widget.studentId,
                                      reason,
                                      supportingImage,
                                      createdDate,
                                      'pending');
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}
