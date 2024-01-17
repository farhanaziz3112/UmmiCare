import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/screens/parent_pages/child/health/addNewVaccineAppointment.dart';
import 'package:ummicare/screens/parent_pages/child/health/editVaccineAppointment.dart';
import 'package:ummicare/services/patientDatabase.dart';

class healthAppointment extends StatefulWidget {
  const healthAppointment(
      {super.key,
      required this.childId,
      required this.healthId,
      required this.parentId});
  final String childId;
  final String parentId;
  final String healthId;

  @override
  State<healthAppointment> createState() => _healthCalendarState();
}

class _healthCalendarState extends State<healthAppointment> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay _selectTime = TimeOfDay.now();
  Map<DateTime, List<String>> _events = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Health Appointment",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffe1eef5),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2050),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            selectedDayPredicate: (day) {
              // Function to determine if a day is selected
              return isSameDay(_selectedDay, day);
            },
            calendarStyle: const CalendarStyle(
              selectedTextStyle: TextStyle(
                color: Colors
                    .blue, // Change this color to the desired color for the selected date
                fontWeight: FontWeight.bold,
              ),
              todayTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            eventLoader: (day) {
              return _events[day] ?? [];
            },
          ),
          SizedBox(height: 20),
          if (_selectedDay != null)
            StreamBuilder<List<VaccinationAppointmentModel>>(
              stream: PatientDatabaseService().allVaccincationAppointmentData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Column(
                    children: <Widget>[
                      Text(
                        'No health appointments for this day.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Color(0xff8290F0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Container(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              size: 25.0,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        addNewVaccineAppointment(
                                            selectedDay: _selectedDay,
                                            time: _selectTime,
                                            healthId: widget.healthId,
                                            parentId: widget.parentId,
                                            childId: widget.childId,),
                                  ));
                            },
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  final vaccinationAppointmentData = snapshot.data!;
                  String sd = DateFormat('yyyy-MM-dd').format(_selectedDay!);

                  for (int i = 0; i < vaccinationAppointmentData.length; i++) {
                    if (vaccinationAppointmentData[i].vaccineDate == sd) {
                      // Display data for the selected date
                      return Column(
                        children: <Widget>[
                          Text(
                            'Health Appointments on ${DateFormat('yyyy-MM-dd').format(_selectedDay!)}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Time: ${vaccinationAppointmentData[i].vaccineTime}',
                            style: TextStyle(fontSize: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 50,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Color(0xff8290F0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              editVaccineAppointment(
                                            selectedDay: _selectedDay,
                                            time: _selectTime,
                                            healthId: widget.healthId,
                                            vaccinationAppointmentId:
                                                vaccinationAppointmentData[i]
                                                    .vaccinationAppointmentId,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                width: 50,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Color(0xff8290F0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      DocumentReference documentReference =
                                          FirebaseFirestore.instance
                                              .collection(
                                                  "Vaccination Appointment")
                                              .doc(vaccinationAppointmentData[i]
                                                  .vaccinationAppointmentId);

                                      await documentReference.delete();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  }
                  return Column(
                    children: <Widget>[
                      Text(
                        'No health appointments for this day.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color(0xff8290F0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              size: 25.0,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      addNewVaccineAppointment(
                                    selectedDay: _selectedDay,
                                    time: _selectTime,
                                    healthId: widget.healthId,
                                    parentId: widget.parentId,
                                    childId: widget.childId,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            )
        ],
      ),
    );
  }
}
