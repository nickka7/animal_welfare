/// resultCode : "200"
/// status : "SUCCESS"
/// errorMessage : null
/// latest : {"medicalName":"การตรวจสุขภาพสุขใจ ครั้งที่2","date":"2021-12-20T17:00:00.000Z"}
/// data : [{"medicalID":"M001","medicalName":"การตรวจสุขภาพสุขใจ ครั้งที่1","date":"2021-12-13T17:00:00.000Z","time":"07:00:00"},{"medicalID":"M002","medicalName":"การตรวจสุขภาพสุขใจ ครั้งที่2","date":"2021-12-20T17:00:00.000Z","time":"07:00:00"}]

class MedHis {
  MedHis({
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

  MedHis.fromJson(dynamic json) {
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

/// medicalID : "M001"
/// medicalName : "การตรวจสุขภาพสุขใจ ครั้งที่1"
/// date : "2021-12-13T17:00:00.000Z"
/// time : "07:00:00"

class Data {
  Data({
      String? medicalID, 
      String? medicalName, 
      String? date, 
      String? time,}){
    _medicalID = medicalID;
    _medicalName = medicalName;
    _date = date;
    _time = time;
}

  Data.fromJson(dynamic json) {
    _medicalID = json['medicalID'];
    _medicalName = json['medicalName'];
    _date = json['date'];
    _time = json['time'];
  }
  String? _medicalID;
  String? _medicalName;
  String? _date;
  String? _time;

  String? get medicalID => _medicalID;
  String? get medicalName => _medicalName;
  String? get date => _date;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['medicalID'] = _medicalID;
    map['medicalName'] = _medicalName;
    map['date'] = _date;
    map['time'] = _time;
    return map;
  }

}

/// medicalName : "การตรวจสุขภาพสุขใจ ครั้งที่2"
/// date : "2021-12-20T17:00:00.000Z"

class Latest {
  Latest({
      String? medicalName, 
      String? date,}){
    _medicalName = medicalName;
    _date = date;
}

  Latest.fromJson(dynamic json) {
    _medicalName = json['medicalName'];
    _date = json['date'];
  }
  String? _medicalName;
  String? _date;

  String? get medicalName => _medicalName;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['medicalName'] = _medicalName;
    map['date'] = _date;
    return map;
  }

}