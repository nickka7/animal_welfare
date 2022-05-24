class ListOfResearcher {
  String? status;
  List<Message>? message;

  ListOfResearcher({this.status, this.message});

  ListOfResearcher.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? userID;
  String? firstName;
  String? lastName;
  Null dateOfBirth;
  Null gender;
  Null mobileNumber;
  Null email;
  Null lineID;
  String? image;
  Null address;
  String? roleID;
  String? nameTH;
  String? nameENG;

  Message(
      {this.userID,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.gender,
      this.mobileNumber,
      this.email,
      this.lineID,
      this.image,
      this.address,
      this.roleID,
      this.nameTH,
      this.nameENG});

  Message.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    lineID = json['lineID'];
    image = json['image'];
    address = json['address'];
    roleID = json['roleID'];
    nameTH = json['nameTH'];
    nameENG = json['nameENG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['lineID'] = this.lineID;
    data['image'] = this.image;
    data['address'] = this.address;
    data['roleID'] = this.roleID;
    data['nameTH'] = this.nameTH;
    data['nameENG'] = this.nameENG;
    return data;
  }
}