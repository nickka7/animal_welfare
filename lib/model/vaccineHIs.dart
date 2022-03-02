/// resultCode : "200"
/// status : "SUCCESS"
/// errorMessage : null
/// latest : {"vaccinateID":15,"vaccineName":"พิษสุนัขบ้า","date":"2022-03-02"}
/// data : [{"vaccinateID":15,"vaccineName":"พิษสุนัขบ้า","date":"2022-03-02","time":"12:56:14"},{"vaccinateID":17,"vaccineName":"พิษสุนัขบ้า","date":"2022-03-02","time":"13:03:11"},{"vaccinateID":18,"vaccineName":"พิษสุนัขบ้า","date":"2022-03-02","time":"13:05:44"},{"vaccinateID":1,"vaccineName":"พิษสุนัขบ้า","date":"2021-12-02","time":"10:00:00"},{"vaccinateID":11,"vaccineName":"บาดทะยัก","date":"2021-12-01","time":"10:00:00"},{"vaccinateID":4,"vaccineName":"บาดทะยัก","date":"2021-11-01","time":"11:00:00"}]

class VacHis {
  VacHis({
      String? resultCode, 
      String? status, 
      dynamic errorMessage, 
      Latest? latest, 
      List<Data>? data,}){
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _latest = latest;
    _data = data;
}

  VacHis.fromJson(dynamic json) {
    _resultCode = json['resultCode'];
    _status = json['status'];
    _errorMessage = json['errorMessage'];
    _latest = json['latest'] != null ? Latest.fromJson(json['latest']) : null;
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
  Latest? _latest;
  List<Data>? _data;

  String? get resultCode => _resultCode;
  String? get status => _status;
  dynamic get errorMessage => _errorMessage;
  Latest? get latest => _latest;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resultCode'] = _resultCode;
    map['status'] = _status;
    map['errorMessage'] = _errorMessage;
    if (_latest != null) {
      map['latest'] = _latest?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// vaccinateID : 15
/// vaccineName : "พิษสุนัขบ้า"
/// date : "2022-03-02"
/// time : "12:56:14"

class Data {
  Data({
      int? vaccinateID, 
      String? vaccineName, 
      String? date, 
      String? time,}){
    _vaccinateID = vaccinateID;
    _vaccineName = vaccineName;
    _date = date;
    _time = time;
}

  Data.fromJson(dynamic json) {
    _vaccinateID = json['vaccinateID'];
    _vaccineName = json['vaccineName'];
    _date = json['date'];
    _time = json['time'];
  }
  int? _vaccinateID;
  String? _vaccineName;
  String? _date;
  String? _time;

  int? get vaccinateID => _vaccinateID;
  String? get vaccineName => _vaccineName;
  String? get date => _date;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vaccinateID'] = _vaccinateID;
    map['vaccineName'] = _vaccineName;
    map['date'] = _date;
    map['time'] = _time;
    return map;
  }

}

/// vaccinateID : 15
/// vaccineName : "พิษสุนัขบ้า"
/// date : "2022-03-02"

class Latest {
  Latest({
      int? vaccinateID, 
      String? vaccineName, 
      String? date,}){
    _vaccinateID = vaccinateID;
    _vaccineName = vaccineName;
    _date = date;
}

  Latest.fromJson(dynamic json) {
    _vaccinateID = json['vaccinateID'];
    _vaccineName = json['vaccineName'];
    _date = json['date'];
  }
  int? _vaccinateID;
  String? _vaccineName;
  String? _date;

  int? get vaccinateID => _vaccinateID;
  String? get vaccineName => _vaccineName;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vaccinateID'] = _vaccinateID;
    map['vaccineName'] = _vaccineName;
    map['date'] = _date;
    return map;
  }

}