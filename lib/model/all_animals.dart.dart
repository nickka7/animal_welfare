class AllAnimals {
  AllAnimals({
    String? resultCode,
    String? status,
    dynamic errorMessage,
    Data? data,
    List<Bio>? bio,
  }) {
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _data = data;
    _bio = bio;
  }

  AllAnimals.fromJson(dynamic json) {
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

class Bio {
  Bio({
    String? animalID,
    String? animalName,
    String? typeName,
    String? gender,
    String? weight,
    String? age,
    String? image,
  }) {
    _animalID = animalID;
    _animalName = animalName;
    _typeName = typeName;
    _gender = gender;
    _weight = weight;
    _age = age;
    _image = image;
  }

  Bio.fromJson(dynamic json) {
    _animalID = json['animalID'];
    _animalName = json['animalName'];
    _typeName = json['typeName'];
    _gender = json['gender'];
    _weight = json['weight'];
    _age = json['age'];
    _image = json['image'];
  }
  String? _animalID;
  String? _animalName;
  String? _typeName;
  String? _gender;
  String? _weight;
  String? _age;
  String? _image;

  String? get animalID => _animalID;
  String? get animalName => _animalName;
  String? get typeName => _typeName;
  String? get gender => _gender;
  String? get weight => _weight;
  String? get age => _age;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['animalID'] = _animalID;
    map['animalName'] = _animalName;
    map['typeName'] = _typeName;
    map['gender'] = _gender;
    map['weight'] = _weight;
    map['age'] = _age;
    map['image'] = _image;
    return map;
  }
}

class Data {
  Data({
    int? amount,
  }) {
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
