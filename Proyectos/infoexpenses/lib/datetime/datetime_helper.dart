String convertDateTimeToString(DateTime dateTime) {
  // anno en formato yyyy
  String year = dateTime.year.toString();
  // mes en formato mm
  String month = dateTime.month.toString().padLeft(2, '0');
  // dia en formato dd
  String day = dateTime.day.toString().padLeft(2, '0');
  // se combina en ddmmyyyy
  String date = day + month + year;

  return date;
}