class MeetingRoom {
  String? status;
  List<Message>? message;

  MeetingRoom({this.status, this.message});

  MeetingRoom.fromJson(Map<String, dynamic> json) {
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
  int? bookingID;
  String? requestID;
  String? requestName;
  String? build;
  String? room;
  String? time;
  String? date;

  Message(
      {this.bookingID,
      this.requestID,
      this.requestName,
      this.build,
      this.room,
      this.time,
      this.date});

  Message.fromJson(Map<String, dynamic> json) {
    bookingID = json['bookingID'];
    requestID = json['requestID'];
    requestName = json['requestName'];
    build = json['build'];
    room = json['room'];
    time = json['time'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingID'] = this.bookingID;
    data['requestID'] = this.requestID;
    data['requestName'] = this.requestName;
    data['build'] = this.build;
    data['room'] = this.room;
    data['time'] = this.time;
    data['date'] = this.date;
    return data;
  }
}

class Builds {
  String? resultCode;
  String? status;
  Null? errorMessage;
  List<Data>? data;

  Builds({this.resultCode, this.status, this.errorMessage, this.data});

  Builds.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    status = json['status'];
    errorMessage = json['errorMessage'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['status'] = this.status;
    data['errorMessage'] = this.errorMessage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? build;

  Data({this.build});

  Data.fromJson(Map<String, dynamic> json) {
    build = json['build'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['build'] = this.build;
    return data;
  }
}