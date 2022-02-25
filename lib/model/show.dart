/// resultCode : "200"
/// status : "SUCCESS"
/// errorMessage : null
/// data : [{"showID":5,"startDate":"2021-11-30T17:00:00.000Z","startTime":"10:00:00","endDate":"2021-11-30T17:00:00.000Z","endTime":"10:30:00","showName":"โชว์ช้าง","location":"ลานจัดแสดงช้าง โซนA","status":"ยังไม่แสดง","totalAudience":2},{"showID":6,"startDate":"2021-11-30T17:00:00.000Z","startTime":"11:00:00","endDate":"2021-11-30T17:00:00.000Z","endTime":"11:30:00","showName":"โชว์ลิง","location":"ลานจัดแสดงลิง โซนC","status":"ยังไม่แสดง","totalAudience":2},{"showID":7,"startDate":"2021-11-30T17:00:00.000Z","startTime":"14:00:00","endDate":"2021-11-30T17:00:00.000Z","endTime":"14:30:00","showName":"โชว์แมวน้ำ","location":"ลานจัดแสดงแมวน้ำ โซนD","status":"ยังไม่แสดง","totalAudience":1},{"showID":8,"startDate":"2021-11-30T17:00:00.000Z","startTime":"15:00:00","endDate":"2021-11-30T17:00:00.000Z","endTime":"15:30:00","showName":"โชว์แมวน้ำ","location":"ลานจัดแสดงแมวน้ำ โซนD","status":"ยังไม่แสดง","totalAudience":1}]

class Show {
  Show({
      String? resultCode, 
      String? status, 
      dynamic errorMessage, 
      List<Data>? data,}){
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _data = data;
}

  Show.fromJson(dynamic json) {
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

/// showID : 5
/// startDate : "2021-11-30T17:00:00.000Z"
/// startTime : "10:00:00"
/// endDate : "2021-11-30T17:00:00.000Z"
/// endTime : "10:30:00"
/// showName : "โชว์ช้าง"
/// location : "ลานจัดแสดงช้าง โซนA"
/// status : "ยังไม่แสดง"
/// totalAudience : 2

class Data {
  Data({
      int? showID, 
      String? startDate, 
      String? startTime, 
      String? endDate, 
      String? endTime, 
      String? showName, 
      String? location, 
      String? status, 
      int? totalAudience,}){
    _showID = showID;
    _startDate = startDate;
    _startTime = startTime;
    _endDate = endDate;
    _endTime = endTime;
    _showName = showName;
    _location = location;
    _status = status;
    _totalAudience = totalAudience;
}

  Data.fromJson(dynamic json) {
    _showID = json['showID'];
    _startDate = json['startDate'];
    _startTime = json['startTime'];
    _endDate = json['endDate'];
    _endTime = json['endTime'];
    _showName = json['showName'];
    _location = json['location'];
    _status = json['status'];
    _totalAudience = json['totalAudience'];
  }
  int? _showID;
  String? _startDate;
  String? _startTime;
  String? _endDate;
  String? _endTime;
  String? _showName;
  String? _location;
  String? _status;
  int? _totalAudience;

  int? get showID => _showID;
  String? get startDate => _startDate;
  String? get startTime => _startTime;
  String? get endDate => _endDate;
  String? get endTime => _endTime;
  String? get showName => _showName;
  String? get location => _location;
  String? get status => _status;
  int? get totalAudience => _totalAudience;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['showID'] = _showID;
    map['startDate'] = _startDate;
    map['startTime'] = _startTime;
    map['endDate'] = _endDate;
    map['endTime'] = _endTime;
    map['showName'] = _showName;
    map['location'] = _location;
    map['status'] = _status;
    map['totalAudience'] = _totalAudience;
    return map;
  }

}