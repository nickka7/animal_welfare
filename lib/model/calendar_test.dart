class CalendarTest {
  CalendarTest({
      String? resultCode, 
      String? status, 
      dynamic errorMessage, 
      List<Data>? data,}){
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _data = data;
}

  CalendarTest.fromJson(dynamic json) {
    _resultCode = json['resultCode'];
    _status = json['status'];
    _errorMessage = json['errorMessage'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _resultCode;
  String? _status;
  dynamic _errorMessage;
  List<Data>? _data;

  String? get resultCode => _resultCode;
  String? get status => _status;
  dynamic get errorMessage => _errorMessage;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resultCode'] = _resultCode;
    map['status'] = _status;
    map['errorMessage'] = _errorMessage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      String? calendarName, 
      String? startDate, 
      String? endDate, 
      String? location,}){
    _calendarName = calendarName;
    _startDate = startDate;
    _endDate = endDate;
    _location = location;
}

  Data.fromJson(dynamic json) {
    _calendarName = json['calendarName'];
    _startDate = json['startDate'];
    _endDate = json['endDate'];
    _location = json['location'];
  }
  String? _calendarName;
  String? _startDate;
  String? _endDate;
  String? _location;

  String? get calendarName => _calendarName;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['calendarName'] = _calendarName;
    map['startDate'] = _startDate;
    map['endDate'] = _endDate;
    map['location'] = _location;
    return map;
  }

}