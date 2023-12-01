import 'package:flutter/material.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/screens/parent_pages/child/education/registerNewEducationPages.dart/academicCalendarTile.dart';

class academicCalendarList extends StatefulWidget {
  const academicCalendarList({super.key, required this.list, required this.studentId});
  final List<academicCalendarModel> list;
  final String studentId;

  @override
  State<academicCalendarList> createState() => _academicCalendarListState();
}

class _academicCalendarListState extends State<academicCalendarList> {
  @override
  Widget build(BuildContext context) {
    if (widget.list.isEmpty) {
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
        itemCount: widget.list.length,
        itemBuilder: ((context, index) {
          return academicCalendarTile(
            academicCalendar: widget.list[index],
            studentId: widget.studentId
          );
        }),
      );
    }
  }
}