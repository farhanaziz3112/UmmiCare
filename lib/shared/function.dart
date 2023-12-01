String convertTimeToDate(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return date.day.toString() +
      " / " +
      date.month.toString() +
      " / " +
      date.year.toString();
}

String convertTimeToDateWithStringMonth(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return date.day.toString() +
      " " +
      monthToString(date.month) +
      " " +
      date.year.toString();
}

String monthToString(int month) {
  List<String> months = [
    'Jan',
    'Feb',
    'Mac',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];
  return months.elementAt(month-1);
}

int getAge(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime birthDate = DateTime.fromMillisecondsSinceEpoch(temp);
  DateTime currentDate = DateTime.now();
  DateTime from = DateTime(birthDate.year, birthDate.month, birthDate.day);
  DateTime to = DateTime(currentDate.year, currentDate.month, currentDate.day);
  return (to.difference(from).inDays / 365).round();
}

String getAgeCategory(int age) {
  if (age <= 3) {
    return 'Newborn to 3 years old';
  } else if (3 < age && age <= 6) {
    return '3 to 6 years old';
  } else if (6 < age && age <= 12) {
    return '7 to 12 years old';
  } else {
    return '13 years old and above';
  }
}

String getLastSignedInFormat(String timeInMilliSeconds) {
  int temp = int.parse(timeInMilliSeconds);
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(temp);
  return dateTime.hour.toString() +
      ":" +
      dateTime.minute.toString() +
      " " + 
      dateTime.day.toString() +
      "/" +
      dateTime.month.toString() +
      "/" +
      dateTime.year.toString();
}
