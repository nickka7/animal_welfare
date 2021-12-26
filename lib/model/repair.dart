/// resultCode : "200"
/// status : "SUCCESS"
/// errorMessage : null
/// data : [{"maintenanceID":5,"requestMessage":"ไฟไม่ติด2234","location":"ตึกพระจอมเกล้า 5552234","image":"http://192.168.1.103:3000/sek2.jpg","status":"รอดำเนินการ","createDtm":"2021-12-19T11:40:01.000Z"},{"maintenanceID":8,"requestMessage":"เครื่องปริ้นเปิดไม่ได้","location":"ตึก ceo ชั้น  77","image":"http://192.168.1.103:3000/MoKSQ2LqGaN1i2ByWNEVSKg6-1.jpeg","status":"รอดำเนินการ","createDtm":"2021-12-24T00:10:04.000Z"},{"maintenanceID":9,"requestMessage":"เครื่องปริ้นเปิดไม่ได้","location":"ตึก ceo ชั้น  77","image":"http://192.168.1.103:3000/candy.jpg","status":"รอดำเนินการ","createDtm":"2021-12-26T01:03:40.000Z"},{"maintenanceID":11,"requestMessage":"qa","location":"aaq","image":"http://192.168.1.103:3000/image_picker_E879251E-2D5A-4BE9-BE5E-DB769EEDADF5-14198-0000050F06A647FC.jpg","status":"รอดำเนินการ","createDtm":"2021-12-26T03:48:06.000Z"}]

class Repair {
  Repair({
      String? resultCode, 
      String? status, 
      dynamic errorMessage, 
      List<Data>? data,}){
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _data = data;
}

  Repair.fromJson(dynamic json) {
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

/// maintenanceID : 5
/// requestMessage : "ไฟไม่ติด2234"
/// location : "ตึกพระจอมเกล้า 5552234"
/// image : "http://192.168.1.103:3000/sek2.jpg"
/// status : "รอดำเนินการ"
/// createDtm : "2021-12-19T11:40:01.000Z"

class Data {
  Data({
      int? maintenanceID, 
      String? requestMessage, 
      String? location, 
      String? image, 
      String? status, 
      String? createDtm,}){
    _maintenanceID = maintenanceID;
    _requestMessage = requestMessage;
    _location = location;
    _image = image;
    _status = status;
    _createDtm = createDtm;
}

  Data.fromJson(dynamic json) {
    _maintenanceID = json['maintenanceID'];
    _requestMessage = json['requestMessage'];
    _location = json['location'];
    _image = json['image'];
    _status = json['status'];
    _createDtm = json['createDtm'];
  }
  int? _maintenanceID;
  String? _requestMessage;
  String? _location;
  String? _image;
  String? _status;
  String? _createDtm;

  int? get maintenanceID => _maintenanceID;
  String? get requestMessage => _requestMessage;
  String? get location => _location;
  String? get image => _image;
  String? get status => _status;
  String? get createDtm => _createDtm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maintenanceID'] = _maintenanceID;
    map['requestMessage'] = _requestMessage;
    map['location'] = _location;
    map['image'] = _image;
    map['status'] = _status;
    map['createDtm'] = _createDtm;
    return map;
  }

}