/// resultCode : "200"
/// status : "SUCCESS"
/// errorMessage : null
/// total : [{"typeName":"ช้าง","total":8},{"typeName":"ม้าลาย","total":2},{"typeName":"ยีราฟ","total":2},{"typeName":"เสือ","total":5}]
/// vaccinate : [{"typeName":"ช้าง","vaccinate":2},{"typeName":"ม้าลาย","vaccinate":1},{"typeName":"ยีราฟ","vaccinate":1},{"typeName":"เสือ","vaccinate":1}]

class GetReport {
  GetReport({
      String? resultCode, 
      String? status, 
      dynamic errorMessage, 
      List<Total>? total, 
      List<Vaccinate>? vaccinate,}){
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _total = total;
    _vaccinate = vaccinate;
}

  GetReport.fromJson(dynamic json) {
    _resultCode = json['resultCode'];
    _status = json['status'];
    _errorMessage = json['errorMessage'];
    if (json['total'] != null) {
      _total = [];
      json['total'].forEach((v) {
        _total?.add(Total.fromJson(v));
      });
    }
    if (json['vaccinate'] != null) {
      _vaccinate = [];
      json['vaccinate'].forEach((v) {
        _vaccinate?.add(Vaccinate.fromJson(v));
      });
    }
  }
  String? _resultCode;
  String? _status;
  dynamic _errorMessage;
  List<Total>? _total;
  List<Vaccinate>? _vaccinate;

  String? get resultCode => _resultCode;
  String? get status => _status;
  dynamic get errorMessage => _errorMessage;
  List<Total>? get total => _total;
  List<Vaccinate>? get vaccinate => _vaccinate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resultCode'] = _resultCode;
    map['status'] = _status;
    map['errorMessage'] = _errorMessage;
    if (_total != null) {
      map['total'] = _total?.map((v) => v.toJson()).toList();
    }
    if (_vaccinate != null) {
      map['vaccinate'] = _vaccinate?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// typeName : "ช้าง"
/// vaccinate : 2

class Vaccinate {
  Vaccinate({
      String? typeName, 
      int? vaccinate,}){
    _typeName = typeName;
    _vaccinate = vaccinate;
}

  Vaccinate.fromJson(dynamic json) {
    _typeName = json['typeName'];
    _vaccinate = json['vaccinate'];
  }
  String? _typeName;
  int? _vaccinate;

  String? get typeName => _typeName;
  int? get vaccinate => _vaccinate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['typeName'] = _typeName;
    map['vaccinate'] = _vaccinate;
    return map;
  }

}

/// typeName : "ช้าง"
/// total : 8

class Total {
  Total({
      String? typeName, 
      int? total,}){
    _typeName = typeName;
    _total = total;
}

  Total.fromJson(dynamic json) {
    _typeName = json['typeName'];
    _total = json['total'];
  }
  String? _typeName;
  int? _total;

  String? get typeName => _typeName;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['typeName'] = _typeName;
    map['total'] = _total;
    return map;
  }

}