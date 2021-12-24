class CalendarData {
  late String calendarID;
  late String calendarName;
  late String startDate;
  late String startTime;
  late String endDate;
  late String endTime;
  late String location;
  late String createDtm;
  Null updateDtm;

  CalendarData(
      {required this.calendarID,
      required this.calendarName,
      required this.startDate,
      required this.startTime,
      required this.endDate,
      required this.endTime,
      required this.location,
      required this.createDtm,
      this.updateDtm});

   CalendarData.fromJson(Map<String, dynamic> json) {
    calendarID = json['calendarID'];
    calendarName = json['calendarName'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    endDate = json['endDate'];
    endTime = json['endTime'];
    location = json['location'];
    createDtm = json['createDtm'];
    updateDtm = json['updateDtm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calendarID'] = this.calendarID;
    data['calendarName'] = this.calendarName;
    data['startDate'] = this.startDate;
    data['startTime'] = this.startTime;
    data['endDate'] = this.endDate;
    data['endTime'] = this.endTime;
    data['location'] = this.location;
    data['createDtm'] = this.createDtm;
    data['updateDtm'] = this.updateDtm;
    return data;
  }
}