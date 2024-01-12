class academicCalendarModel {
  final String academicCalendarId;
  final String schoolId;
  final String classId;
  final String teacherId;
  final String academicCalendarStartDate;
  final String academicCalendarEndDate;
  final String noOfStudent;
  final String registrationStatus;

  academicCalendarModel(
      {required this.academicCalendarId,
      required this.schoolId,
      required this.classId,
      required this.teacherId,
      required this.academicCalendarStartDate,
      required this.academicCalendarEndDate,
      required this.noOfStudent,
      required this.registrationStatus});
}

class withdrawalRequestModel {
  final String withdrawalRequestModelId;
  final String academicCalendarId;
  final String classId;
  final String schoolId;
  final String teacherId;
  final String studentId;
  final String reason;
  final String supportingImage;
  final String createdAt;
  final String status;

  withdrawalRequestModel(
      {required this.withdrawalRequestModelId,
      required this.academicCalendarId,
      required this.classId,
      required this.schoolId,
      required this.teacherId,
      required this.studentId,
      required this.reason,
      required this.supportingImage,
      required this.createdAt,
      required this.status});
}

class classEvent {
  final String classEventId;
  final String academicCalendarId;
  final String eventName;
  final String eventDescription;
  final String eventStartDate;
  final String eventEndDate;
  final String createdAt;

  classEvent({
    required this.classEventId,
    required this.academicCalendarId,
    required this.eventName,
    required this.eventDescription,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.createdAt,
  });
}

class classAnnouncement {
  final String classAnnouncementId;
  final String academicCalendarId;
  final String announcementTitle;
  final String announcementDescription;
  final String createdAt;

  classAnnouncement(
      {required this.classAnnouncementId,
      required this.academicCalendarId,
      required this.announcementTitle,
      required this.announcementDescription,
      required this.createdAt});
}
