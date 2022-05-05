/// status : "Success"
/// message : [{"id":1,"checkIn":"2564-12-15 09:00:14","location_checkIn":null},{"id":2,"checkIn":"2564-12-15 08:55:36","location_checkIn":null},{"id":3,"checkIn":null,"location_checkIn":null},{"id":4,"checkIn":"2564-12-15 09:01:53","location_checkIn":null},{"id":5,"checkIn":"2564-12-15 09:00:11","location_checkIn":null},{"id":6,"checkIn":null,"location_checkIn":null},{"id":7,"checkIn":"2564-12-17 09:05:52","location_checkIn":null},{"id":8,"checkIn":"2564-12-17 08:56:37","location_checkIn":null},{"id":9,"checkIn":"2564-12-17 09:00:29","location_checkIn":null},{"id":10,"checkIn":"2564-12-17 09:00:28","location_checkIn":null},{"id":13,"checkIn":"0000-00-00 00:00:00","location_checkIn":null},{"id":23,"checkIn":"0000-00-00 00:00:00","location_checkIn":null},{"id":24,"checkIn":"0000-00-00 00:00:00","location_checkIn":null},{"id":25,"checkIn":"0000-00-00 00:00:00","location_checkIn":null},{"id":26,"checkIn":"0000-00-00 00:00:00","location_checkIn":null},{"id":27,"checkIn":"0000-00-00 00:00:00","location_checkIn":null},{"id":28,"checkIn":"0000-00-00 00:00:00","location_checkIn":null},{"id":31,"checkIn":"0000-00-00 00:00:00","location_checkIn":null},{"id":32,"checkIn":"2022-02-01 22:19:29","location_checkIn":null},{"id":33,"checkIn":"2022-02-09 08:04:06","location_checkIn":null},{"id":34,"checkIn":"2022-02-09 08:11:08","location_checkIn":null},{"id":35,"checkIn":"2022-02-09 08:11:48","location_checkIn":null},{"id":36,"checkIn":"2022-02-09 08:12:40","location_checkIn":null},{"id":37,"checkIn":"2022-02-09 08:14:21","location_checkIn":null},{"id":38,"checkIn":"2022-02-09 08:18:13","location_checkIn":null},{"id":39,"checkIn":"2022-02-09 08:20:48","location_checkIn":null},{"id":40,"checkIn":"2022-02-10 07:24:42","location_checkIn":null},{"id":47,"checkIn":"2022-04-30 17:59:45","location_checkIn":"A"},{"id":48,"checkIn":"2022-04-30 18:07:42","location_checkIn":"A"},{"id":49,"checkIn":"2022-04-30 18:07:55","location_checkIn":"undefined"}]

class GetMyCheckInTest {
  GetMyCheckInTest({
      String? status, 
      List<Message>? message,}){
    _status = status;
    _message = message;
}

  GetMyCheckInTest.fromJson(dynamic json) {
    _status = json['status'];
    if (json['message'] != null) {
      _message = [];
      json['message'].forEach((v) {
        _message?.add(Message.fromJson(v));
      });
    }
  }
  String? _status;
  List<Message>? _message;

  String? get status => _status;
  List<Message>? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// checkIn : "2564-12-15 09:00:14"
/// location_checkIn : null

class Message {
  Message({
      int? id, 
      String? checkIn, 
      dynamic locationCheckIn,}){
    _id = id;
    _checkIn = checkIn;
    _locationCheckIn = locationCheckIn;
}

  Message.fromJson(dynamic json) {
    _id = json['id'];
    _checkIn = json['checkIn'];
    _locationCheckIn = json['location_checkIn'];
  }
  int? _id;
  String? _checkIn;
  dynamic _locationCheckIn;

  int? get id => _id;
  String? get checkIn => _checkIn;
  dynamic get locationCheckIn => _locationCheckIn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['checkIn'] = _checkIn;
    map['location_checkIn'] = _locationCheckIn;
    return map;
  }

}