import 'package:flutter/material.dart';
import 'package:ummicare/screens/parent_pages/child/childprofile/childProfile.dart';
import 'package:ummicare/screens/parent_pages/child/childprofile/childStory.dart';
import 'package:ummicare/screens/parent_pages/child/childprofile/addNewChildStory.dart';
import 'package:ummicare/screens/parent_pages/child/advisory/advisoryMain.dart';
import 'package:ummicare/screens/parent_pages/child/advisory/advisorProfile.dart';
import 'package:ummicare/screens/parent_pages/child/education/academicCalendar.dart';
import 'package:ummicare/screens/parent_pages/child/education/addNewExamResult.dart';
import 'package:ummicare/screens/parent_pages/child/education/addNewSchoolFee.dart';
import 'package:ummicare/screens/parent_pages/child/education/educationMain.dart';
import 'package:ummicare/screens/parent_pages/child/health/addNewVaccineAppointment.dart';
import 'package:ummicare/screens/parent_pages/child/health/editChildHealth.dart';
import 'package:ummicare/screens/auth/wrapper.dart';


//first name in the route name is the 'type of user'
//example: /parent/child/childprofile : parent user 

Map<String, WidgetBuilder> routes = {
  '/': (context) => Wrapper(),
  //'/parent/child/childprofile': (context) => childProfile(child: null,),
  //'/parent/child/childprofile/editchildprofile': (context) => editChildProfile(),
  '/parent/child/childprofile/childstory': (context) => childStory(),
  '/parent/child/childprofile/addnewchildstory': (context) => addNewChildStory(),
  //'/parent/child/registerchild': (context) => registerChild(),
  '/parent/child/advisory': (context) => advisoryMain(),
  '/parent/child/advisory/advisorprofile': (context) => advisorProfile(),
  '/parent/child/childprofile/education': (context) => educationMain(studentId: '',childId: ''),
  '/parent/child/childprofile/education/academiccalendar': (context) => academicCalendar(),
  '/parent/child/childprofile/education/addnewexamresult': (context) => addNewExamResult(),
  '/parent/child/childprofile/education/addnewschoolfee': (context) => addNewSchoolFee(),
  //'/parent/child/childprofile/education/editchildeducation': (context) => editChildEducation(),
  //'/parent/child/childprofile/health': (context) => healthMain(),
  '/parent/child/childprofile/health/addnewvaccineappointment': (context) => addNewVaccineAppointment(),
  '/parent/child/childprofile/health/editchildhealth': (context) => editChildHealth(),
  //'/parent/child/childprofile/health/vaccinationcalendar': (context) => vaccinationCalendar(),
  //'/settings/editprofile': (context) => editProfile(),
};
