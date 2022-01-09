/// resultCode : "200"
/// status : "SUCCESS"
/// errorMessage : null
/// data : [{"animalName":"ช้าง","amount":2},{"animalName":"เสือ","amount":2}]
/// bio : [{"animalID":"A001","animalName":"สุขใจ","typeName":"ช้าง","gender":"ผู้","weight":"3700","age":"7"},{"animalID":"A002","animalName":"สุขกาย","typeName":"ช้าง","gender":"เมีย","weight":"3540","age":"5"},{"animalID":"A003","animalName":"กล้า","typeName":"เสือ","gender":"ผู้","weight":"55","age":"4"},{"animalID":"A004","animalName":"ใจดี","typeName":"เสือ","gender":"เมีย","weight":"64","age":"4"}]

class Test1 {
  Test1({
      String? resultCode, 
      String? status, 
      dynamic errorMessage, 
      List<Data>? data, 
      List<Bio>? bio,}){
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _data = data;
    _bio = bio;
}

  Test1.fromJson(dynamic json) {
    _resultCode = json['resultCode'];
    _status = json['status'];
    _errorMessage = json['errorMessage'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
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
  List<Data>? _data;
  List<Bio>? _bio;

  String? get resultCode => _resultCode;
  String? get status => _status;
  dynamic get errorMessage => _errorMessage;
  List<Data>? get data => _data;
  List<Bio>? get bio => _bio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resultCode'] = _resultCode;
    map['status'] = _status;
    map['errorMessage'] = _errorMessage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
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
/// weight : "3700"
/// age : "7"

class Bio {
  Bio({
      String? animalID, 
      String? animalName, 
      String? typeName, 
      String? gender, 
      String? weight, 
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
  String? _weight;
  String? _age;

  String? get animalID => _animalID;
  String? get animalName => _animalName;
  String? get typeName => _typeName;
  String? get gender => _gender;
  String? get weight => _weight;
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

/// animalName : "ช้าง"
/// amount : 2

class Data {
  Data({
      String? animalName, 
      int? amount,}){
    _animalName = animalName;
    _amount = amount;
}

  Data.fromJson(dynamic json) {
    _animalName = json['animalName'];
    _amount = json['amount'];
  }
  String? _animalName;
  int? _amount;

  String? get animalName => _animalName;
  int? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['animalName'] = _animalName;
    map['amount'] = _amount;
    return map;
  }

}