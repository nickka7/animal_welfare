/// status : "Success"
/// message : [{"door":"A","latitude":13.7744086,"longitude":100.5171},{"door":"B","latitude":13.7744086,"longitude":100.5171},{"door":"C","latitude":13.7746084,"longitude":100.5171},{"door":"D","latitude":13.7745087,"longitude":100.5171},{"door":"E","latitude":13.7745087,"longitude":100.5171},{"door":"H","latitude":16,"longitude":17},{"door":"T","latitude":14,"longitude":15},{"door":"X","latitude":13.7745087,"longitude":100.5171},{"door":"Z","latitude":13.7745087,"longitude":100.5171}]

class GetLocation {
  GetLocation({
      String? status, 
      List<Message>? message,}){
    _status = status;
    _message = message;
}

  GetLocation.fromJson(dynamic json) {
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

/// door : "A"
/// latitude : 13.7744086
/// longitude : 100.5171

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