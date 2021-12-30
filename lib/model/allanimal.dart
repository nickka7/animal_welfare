class AllanimalData {
  String? resultCode;
  String? status;
  Null errorMessage;
   Data? data;
  List<Bio>? bio;

  AllanimalData(
      { this.resultCode,  this.status, this.errorMessage,  this.data,  this.bio});

  AllanimalData.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    status = json['status'];
    errorMessage = json['errorMessage'];
    data = json['data'] ;
    if (json['bio'] != null) {
      bio = [];
      json['bio'].forEach((v) {
        bio?.add(new Bio.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['status'] = this.status;
    data['errorMessage'] = this.errorMessage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.bio != null) {
      data['bio'] = this.bio!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? amount;

  Data({ this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    return data;
  }
}

class Bio {
  String? animalID;
  String? animalName;
  String? typeName;
  String? gender;
  double? weight;
  String? age;

  Bio(
      {this.animalID,
      this.animalName,
      this.typeName,
      this.gender,
      this.weight,
      this.age});

  Bio.fromJson(Map<String, dynamic> json) {
    animalID = json['animalID'];
    animalName = json['animalName'];
    typeName = json['typeName'];
    gender = json['gender'];
    weight = json['weight'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['animalID'] = this.animalID;
    data['animalName'] = this.animalName;
    data['typeName'] = this.typeName;
    data['gender'] = this.gender;
    data['weight'] = this.weight;
    data['age'] = this.age;
    return data;
  }
}