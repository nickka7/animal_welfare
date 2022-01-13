/// resultCode : "200"
/// status : "SUCCESS"
/// errorMessage : null
/// data : [{"researchID":"R001","researchName":"การวิจัยการกินอาหารตอนกลางคืนของช้าง","typeName":"ช้าง","researchDetail":"วิจัยการกินอาหารตอนกลางคืนของช้าง ปรากฎว่าท้อเงสีย","date":"2021-11-04T17:00:00.000Z"},{"researchID":"R002","researchName":"การวิจัยการนอนของเสือ","typeName":"เสือ","researchDetail":"วิจัยการนอนของเสือช่วงกลางวัน ปรากฎว่านอนหลับไม่เพียงพอ","date":"2021-11-08T17:00:00.000Z"},{"researchID":"R003","researchName":"การวิจัยการนอนของม้าลาย","typeName":"ม้าลาย","researchDetail":"วิจัยการนอนของม้าลาย พบว่าการนอนหลับของม้าลายนั้นใช้เวลานานกว่าจะหลับ","date":"2021-12-01T17:00:00.000Z"},{"researchID":"R004","researchName":"การวิจัยการนอนของยีราฟ","typeName":"ยีราฟ","researchDetail":"วิจัยการนอนของยีราฟ พบว่าไม่สามารถนอนร่วมกับยีราฟตัวอื่นได้เพราะคอมันยาวเกินไป","date":"2021-12-12T17:00:00.000Z"}]

class ResearchData {
  ResearchData({
      String? resultCode, 
      String? status, 
      dynamic errorMessage, 
      List<Data>? data,}){
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _data = data;
}

  ResearchData.fromJson(dynamic json) {
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

/// researchID : "R001"
/// researchName : "การวิจัยการกินอาหารตอนกลางคืนของช้าง"
/// typeName : "ช้าง"
/// researchDetail : "วิจัยการกินอาหารตอนกลางคืนของช้าง ปรากฎว่าท้อเงสีย"
/// date : "2021-11-04T17:00:00.000Z"

class Data {
  Data({
      String? researchID, 
      String? researchName, 
      String? typeName, 
      String? researchDetail, 
      String? date,}){
    _researchID = researchID;
    _researchName = researchName;
    _typeName = typeName;
    _researchDetail = researchDetail;
    _date = date;
}

  Data.fromJson(dynamic json) {
    _researchID = json['researchID'];
    _researchName = json['researchName'];
    _typeName = json['typeName'];
    _researchDetail = json['researchDetail'];
    _date = json['date'];
  }
  String? _researchID;
  String? _researchName;
  String? _typeName;
  String? _researchDetail;
  String? _date;

  String? get researchID => _researchID;
  String? get researchName => _researchName;
  String? get typeName => _typeName;
  String? get researchDetail => _researchDetail;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['researchID'] = _researchID;
    map['researchName'] = _researchName;
    map['typeName'] = _typeName;
    map['researchDetail'] = _researchDetail;
    map['date'] = _date;
    return map;
  }

}