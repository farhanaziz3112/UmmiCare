// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:ummicare/models/activityModel.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/models/scheduleModel.dart';
import 'package:ummicare/services/activityDatabase.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/screens/parent_pages/child/childlist/childlist.dart';
import 'package:ummicare/services/scheduleDatabase.dart';
import 'package:ummicare/shared/calendar.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/shared/function.dart';

class parentMain extends StatefulWidget {
  const parentMain({super.key});

  @override
  State<parentMain> createState() => _parentMainState();
}

class _parentMainState extends State<parentMain> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    parentModel? parent = Provider.of<parentModel?>(context);
    if (parent == null) {
      return Container();
    } else {
      return Column(children: <Widget>[
        Container(
            height: 400,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background/homebg.png"),
                  fit: BoxFit.cover),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(flex: 2, child: Container()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "Welcome, ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${parent.parentFirstName}!',
                            style: const TextStyle(fontSize: 35),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.grey,
                              spreadRadius: 1)
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(parent.parentProfileImg),
                        radius: 40.0,
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Last login: ${_auth.getUserLastSignedIn()}',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(flex: 1, child: Container()),
              ],
            )),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      const Icon(
                        Icons.thumb_up,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('Recent Activities',
                          style:
                              TextStyle(color: Colors.black, fontSize: 17.0)),
                      Expanded(
                        child: Container(),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  StreamBuilder<List<activityModel>>(
                      stream: activityDatabase()
                          .allactivityDataWithParentId(parent.parentId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<activityModel>? activities = snapshot.data;
                          activities!.sort(
                              (a, b) => b.createdAt.compareTo(a.createdAt));
                          return SizedBox(
                            height: 200,
                            width: double.maxFinite,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 250,
                                      childAspectRatio: 0.9,
                                      crossAxisSpacing: 70,
                                      mainAxisSpacing: 10),
                              itemCount: activities.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: const EdgeInsets.only(right: 5.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: activities[index].type ==
                                                    'advisor'
                                                ? const AssetImage(
                                                    "assets/background/activitybg-advisor.png")
                                                : activities[index].type ==
                                                        'child'
                                                    ? const AssetImage(
                                                        "assets/background/activitybg-child.png")
                                                    : activities[index].type ==
                                                            'education'
                                                        ? const AssetImage(
                                                            "assets/background/activitybg-childedu.png")
                                                        : activities[index]
                                                                    .type ==
                                                                'health'
                                                            ? const AssetImage(
                                                                "assets/background/activitybg-childhealth.png")
                                                            : const AssetImage(
                                                                "assets/background/activitybg-buddy.png"),
                                            fit: BoxFit.cover),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          activities[index].activityTitle,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          activities[index].activityDescription,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Expanded(child: Container()),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            convertTimeToDateString(
                                                activities[index].createdAt),
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey[200]),
                                          ),
                                        )
                                      ],
                                    ));
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.calendar_month,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Upcoming Event',
                        style: TextStyle(color: Colors.black, fontSize: 17.0),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 600,
                    child: StreamBuilder<List<scheduleModel>>(
                      stream: scheduleDatabase()
                          .scheduleDataWithParentId(parent.parentId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<scheduleModel>? schedules = snapshot.data;
                          if (schedules!.isNotEmpty) {
                            return SfCalendar(
                              minDate: DateTime.now().subtract(const Duration(days: 5)),
                              maxDate:
                                  DateTime.now().add(const Duration(days: 30)),
                              view: CalendarView.schedule,
                              dataSource: scheduler(_getDataSource(schedules)),
                              timeSlotViewSettings: const TimeSlotViewSettings(
                                  startHour: 0,
                                  endHour: 24,
                                  timeIntervalHeight: 30),
                              monthViewSettings: const MonthViewSettings(
                                  appointmentDisplayMode:
                                      MonthAppointmentDisplayMode.appointment),
                            );
                          } else {
                            return Center(
                              child: noData('Oops! Nothing here...'),
                            );
                          }
                        } else {
                          return Center(child: noData('Oops! Nothing here...'));
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                ]),
          ),
        ),
      ]);
    }
  }

  List<Meeting> _getDataSource(List<scheduleModel>? scheduleList) {
    final List<Color> _colorList = [
      Colors.orange,
      Colors.blueAccent,
      Colors.blueGrey,
      Colors.red,
      Colors.brown,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.teal,
      Colors.lightBlue
    ];
    final List<Meeting> meetings = <Meeting>[];
    for (int i = 0; i < scheduleList!.length; i++) {
      meetings.add(Meeting(
          scheduleList[i].scheduleTitle,
          convertTimeToDate(scheduleList[i].from),
          convertTimeToDate(scheduleList[i].to),
          i > 9 ? _colorList[i - 10] : _colorList[i],
          scheduleList[i].isAllDay == 'true' ? true : false));
    }
    return meetings;
  }
}
