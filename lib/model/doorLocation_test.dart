/// status : "Success"
/// message : [{"door":"12","latitude":1.3243,"longitude":1.321},{"door":"A","latitude":12345,"longitude":12345},{"door":"B","latitude":123456,"longitude":123456},{"door":"C","latitude":12345,"longitude":12345}]

class DoorLocationTest {
  DoorLocationTest({
      String? status, 
      List<Message>? message,}){
    _status = status;
    _message = message;
}

  DoorLocationTest.fromJson(dynamic json) {
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
      map['message'] = _message?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// door : "12"
/// latitude : 1.3243
/// longitude : 1.321

class Message {
  Message({
      String? door, 
      double? latitude, 
      double? longitude,}){
    _door = door;
    _latitude = latitude;
    _longitude = longitude;
}

  Message.fromJson(dynamic json) {
    _door = json['door'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  String? _door;
  double? _latitude;
  double? _longitude;

  String? get door => _door;
  double? get latitude => _latitude;
  double? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['door'] = _door;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }

}