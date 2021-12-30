class ScheduleData {
  ScheduleData({
    String? resultCode,
    String? status,
    dynamic errorMessage,
    List<Data>? data,
  }) {
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _data = data;
  }

  ScheduleData.fromJson(dynamic json) {
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
    String? startDate,
    String? startTime,
    String? endDate,
    String? endTime,
    String? scheduleName,
    String? location,
  }) {
    _startDate = startDate;
    _startTime = startTime;
    _endDate = endDate;
    _endTime = endTime;
    _scheduleName = scheduleName;
    _location = location;
  }

  Data.fromJson(dynamic json) {
    _startDate = json['startDate'];
    _startTime = json['startTime'];
    _endDate = json['endDate'];
    _endTime = json['endTime'];
    _scheduleName = json['scheduleName'];
    _location = json['location'];
  }
  String? _startDate;
  String? _startTime;
  String? _endDate;
  String? _endTime;
  String? _scheduleName;
  String? _location;

  String? get startDate => _startDate;
  String? get startTime => _startTime;
  String? get endDate => _endDate;
  String? get endTime => _endTime;
  String? get scheduleName => _scheduleName;
  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['startDate'] = _startDate;
    map['startTime'] = _startTime;
    map['endDate'] = _endDate;
    map['endTime'] = _endTime;
    map['scheduleName'] = _scheduleName;
    map['location'] = _location;
    return map;
  }
}