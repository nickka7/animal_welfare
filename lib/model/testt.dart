/// resultCode : "200"
/// status : "SUCCESS"
/// errorMessage : null
/// data : [{"showName":"โชว์ช้าง"},{"showName":"โชว์นกแก้ว"},{"showName":"โชว์ลิง"},{"showName":"โชว์แมวน้ำ"}]

class Testt {
  Testt({
      String? resultCode, 
      String? status, 
      dynamic errorMessage, 
      List<Data>? data,}){
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _data = data;
}

  Testt.fromJson(dynamic json) {
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

/// showName : "โชว์ช้าง"

class Data {
  Data({
      String? showName,}){
    _showName = showName;
}

  Data.fromJson(dynamic json) {
    _showName = json['showName'];
  }
  String? _showName;

  String? get showName => _showName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['showName'] = _showName;
    return map;
  }

}