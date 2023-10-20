import 'package:flutter/material.dart';
import 'package:ummicare/screens/advisor_pages/mentee/menteeProfile/menteeProfile.dart';
import 'package:ummicare/screens/parent_pages/child/childprofile/childProfile.dart';
import 'package:ummicare/screens/parent_pages/child/childprofile/childStory.dart';
import 'package:ummicare/screens/parent_pages/child/childprofile/editChildProfile.dart';
import 'package:ummicare/screens/parent_pages/child/childprofile/addNewChildStory.dart';
import 'package:ummicare/screens/parent_pages/child/registerChild.dart';
import 'package:ummicare/screens/parent_pages/child/advisory/advisoryMain.dart';
import 'package:ummicare/screens/parent_pages/child/advisory/advisorProfile.dart';
import 'package:ummicare/screens/parent_pages/child/advisory/chatting.dart';
import 'package:ummicare/screens/parent_pages/child/education/academicCalendar.dart';
import 'package:ummicare/screens/parent_pages/child/education/addNewExamResult.dart';
import 'package:ummicare/screens/parent_pages/child/education/addNewSchoolFee.dart';
import 'package:ummicare/screens/parent_pages/child/education/editChildEducation.dart';
import 'package:ummicare/screens/parent_pages/child/education/educationMain.dart';
import 'package:ummicare/screens/parent_pages/child/health/healthMain.dart';
import 'package:ummicare/screens/parent_pages/child/health/addNewVaccineAppointment.dart';
import 'package:ummicare/screens/parent_pages/child/health/editChildHealth.dart';
import 'package:ummicare/screens/verification/wrapper.dart';
import 'package:ummicare/screens/advisor_pages/mentee/menteeProfile/childProgress.dart';
import 'package:ummicare/screens/advisor_pages/mentee/menteeProfile/chattingAdvisor.dart';


//first name in the route name is the 'type of user'
//example: /parent/child/childprofile : parent user 

Map<String, WidgetBuilder> routes = {
  '/': (context) => Wrapper(),
  //'/parent/child/childprofile': (context) => childProfile(),
  //'/parent/child/childprofile/editchildprofile': (context) => editChildProfile(),
  '/parent/child/childprofile/childstory': (context) => childStory(),
  '/parent/child/childprofile/addnewchildstory': (context) => addNewChildStory(),
  //'/parent/child/registerchild': (context) => registerChild(),
  '/parent/child/advisory': (context) => advisoryMain(),
  '/parent/child/advisory/advisorprofile': (context) => advisorProfile(),
  '/parent/child/advisory/chatting': (context) => chatting(),
  //'/parent/child/childprofile/education': (context) => educationMain(),
  '/parent/child/childprofile/education/academiccalendar': (context) => academicCalendar(),
  '/parent/child/childprofile/education/addnewexamresult': (context) => addNewExamResult(),
  '/parent/child/childprofile/education/addnewschoolfee': (context) => addNewSchoolFee(),
  //'/parent/child/childprofile/education/editchildeducation': (context) => editChildEducation(),
  //'/parent/child/childprofile/health': (context) => healthMain(),
  '/parent/child/childprofile/health/addnewvaccineappointment': (context) => addNewVaccineAppointment(),
  '/parent/child/childprofile/health/editchildhealth': (context) => editChildHealth(),
  //'/parent/child/childprofile/health/vaccinationcalendar': (context) => vaccinationCalendar(),
  '/advisor/mentee/menteeprofile': (context) => menteeProfile(),
  '/advisor/mentee/childprogress': (context) => childProgress(),
  '/advisor/mentee/chattingadvisor': (context) => chattingAdvisor(),
  //'/settings/editprofile': (context) => editProfile(),
};
