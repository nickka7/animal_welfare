/// resultCode : "200"
/// status : "SUCCESS"
/// errorMessage : null
/// data : [{"medicalID":"M001","medicalName":"การตรวจสุขภาพสุขใจ ครั้งที่1","date":"2021-12-13T17:00:00.000Z","time":"07:00:00"},{"medicalID":"M002","medicalName":"การตรวจสุขภาพสุขใจ ครั้งที่2","date":"2021-12-20T17:00:00.000Z","time":"07:00:00"}]

class MedicalHistory {
  MedicalHistory({
      String? resultCode, 
      String? status, 
      dynamic errorMessage, 
      List<Data>? data,}){
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _data = data;
}

  MedicalHistory.fromJson(dynamic json) {
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