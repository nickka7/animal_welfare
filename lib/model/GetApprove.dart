class GetApprove {
  String? resultCode;
  String? status;
  List<Message>? message;

  GetApprove({this.resultCode, this.status, this.message});

  GetApprove.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    status = json['status'];
    if (json['Message'] != null) {
      message = <Message>[];
      json['Message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['status'] = this.status;
    if (this.message != null) {
      data['Message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? firstName;
  String? lastName;
  String? userID;
  String? roleID;
  String? nameTH;
  String? typeLeave;
  String? detail;
  String? url;
  String? status;
  String? dateAbsence;
  int? absenceID;

  Message(
      {this.firstName,
      this.lastName,
      this.userID,
      this.roleID,
      this.nameTH,
      this.typeLeave,
      this.detail,
      this.url,
      this.status,
      this.dateAbsence,
      this.absenceID});

  Message.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    userID = json['userID'];
    roleID = json['roleID'];
    nameTH = json['nameTH'];
    typeLeave = json['type_leave'];
    detail = json['detail'];
    url = json['url'];
    status = json['status'];
    dateAbsence = json['date_absence'];
    absenceID = json['absenceID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userID'] = this.userID;
    data['roleID'] = this.roleID;
    data['nameTH'] = this.nameTH;
    data['type_leave'] = this.typeLeave;
    data['detail'] = this.detail;
    data['url'] = this.url;
    data['status'] = this.status;
    data['date_absence'] = this.dateAbsence;
    data['absenceID'] = this.absenceID;
    return data;
  }
}