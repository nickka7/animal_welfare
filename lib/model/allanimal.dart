/// resultCode : "200"
/// status : "SUCCESS"
/// errorMessage : null
/// data : {"amount":10}
/// bio : [{"animalID":"A001","animalName":"สุขใจ","typeName":"ช้าง","gender":"ผู้","weight":3700,"age":"7"},{"animalID":"A002","animalName":"สุขกาย","typeName":"ช้าง","gender":"เมีย","weight":3540,"age":"5"},{"animalID":"A003","animalName":"กล้า","typeName":"เสือ","gender":"ผู้","weight":55,"age":"4"},{"animalID":"A004","animalName":"ใจดี","typeName":"เสือ","gender":"เมีย","weight":64,"age":"4"},{"animalID":"A005","animalName":"ถุงทอง","typeName":"ม้าลาย","gender":"ผู้","weight":300,"age":"3"},{"animalID":"A006","animalName":"ถุงเงิน","typeName":"ม้าลาย","gender":"เมีย","weight":310,"age":"5"},{"animalID":"A007","animalName":"วินเทอร์","typeName":"ยีราฟ","gender":"ผู้","weight":0.5,"age":"2"},{"animalID":"A008","animalName":"เยลลี่","typeName":"ยีราฟ","gender":"เมีย","weight":0.4,"age":"3"},{"animalID":"A009","animalName":"อัญชัญ","typeName":"ช้าง","gender":"ผู้","weight":3610,"age":"4"},{"animalID":"A010","animalName":"มรกต","typeName":"ช้าง","gender":"เมีย","weight":3600,"age":"3"}]

class Allanimals {
  Allanimals({
      String? resultCode, 
      String? status, 
      dynamic errorMessage, 
      Data? data, 
      List<Bio>? bio,}){
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _data = data;
    _bio = bio;
}

  Allanimals.fromJson(dynamic json) {
    _resultCode = json['resultCode'];
    _status = json['status'];
    _errorMessage = json['errorMessage'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['bio'] != null) {
      _bio = [];
      json['bio'].forEach((v) {
        _bio?.add(Bio.fromJson(v));
      });
    }
  }
  String? _resultCode;
  String? _status;
  dynamic _errorMessage;
  Data? _data;
  List<Bio>? _bio;

  String? get resultCode => _resultCode;
  String? get status => _status;
  dynamic get errorMessage => _errorMessage;
  Data? get data => _data;
  List<Bio>? get bio => _bio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resultCode'] = _resultCode;
    map['status'] = _status;
    map['errorMessage'] = _errorMessage;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    if (_bio != null) {
      map['bio'] = _bio?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// animalID : "A001"
/// animalName : "สุขใจ"
/// typeName : "ช้าง"
/// gender : "ผู้"
/// weight : 3700
/// age : "7"

class Bio {
  Bio({
      String? animalID, 
      String? animalName, 
      String? typeName, 
      String? gender, 
      int? weight, 
      String? age,}){
    _animalID = animalID;
    _animalName = animalName;
    _typeName = typeName;
    _gender = gender;
    _weight = weight;
    _age = age;
}

  Bio.fromJson(dynamic json) {
    _animalID = json['animalID'];
    _animalName = json['animalName'];
    _typeName = json['typeName'];
    _gender = json['gender'];
    _weight = json['weight'];
    _age = json['age'];
  }
  String? _animalID;
  String? _animalName;
  String? _typeName;
  String? _gender;
  int? _weight;
  String? _age;

  String? get animalID => _animalID;
  String? get animalName => _animalName;
  String? get typeName => _typeName;
  String? get gender => _gender;
  int? get weight => _weight;
  String? get age => _age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['animalID'] = _animalID;
    map['animalName'] = _animalName;
    map['typeName'] = _typeName;
    map['gender'] = _gender;
    map['weight'] = _weight;
    map['age'] = _age;
    return map;
  }

}

/// amount : 10

class Data {
  Data({
      int? amount,}){
    _amount = amount;
}

  Data.fromJson(dynamic json) {
    _amount = json['amount'];
  }
  int? _amount;

  int? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = _amount;
    return map;
  }

}