class CalendarData {
  String? calendarID;
  String? calendarName;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  String? location;
  String? createDtm;
  Null updateDtm;

  CalendarData(
      {this.calendarID,
      this.calendarName,
      this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      this.location,
      this.createDtm,
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
