

class feeModel {

  final String feeId;
  final String academicCalendarId;
  final String feeTitle;
  final String feeAmount;
  final String feeDescription;
  final String feeDeadline;

  feeModel({
    required this.feeId,
    required this.academicCalendarId,
    required this.feeTitle,
    required this.feeAmount,
    required this.feeDescription,
    required this.feeDeadline
  });

}

class feePaymentModel {
  
  final String feePaymentId;
  final String feeId;
  final String studentId;
  final String academicCalendarId;
  final String feePaymentAmountPaid;
  final String feePaymentStatus;
  final String feePaymentDate;
  final String feePaymentProofImg;

  feePaymentModel({
    required this.feePaymentId,
    required this.feeId,
    required this.studentId,
    required this.academicCalendarId,
    required this.feePaymentAmountPaid,
    required this.feePaymentStatus,
    required this.feePaymentDate,
    required this.feePaymentProofImg
  });

}

