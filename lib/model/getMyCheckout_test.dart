/// status : "Success"
/// message : [{"id":83,"checkOut":null,"location_checkOut":null},{"id":84,"checkOut":"2022-05-08 20:10:28","location_checkOut":"C"},{"id":85,"checkOut":"2022-05-08 20:26:17","location_checkOut":"out"},{"id":86,"checkOut":"2022-05-08 20:27:47","location_checkOut":"C"}]

class GetMyCheckoutTest {
  GetMyCheckoutTest({
      String? status, 
      List<Message>? message,}){
    _status = status;
    _message = message;
}

  GetMyCheckoutTest.fromJson(dynamic json) {
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

/// id : 83
/// checkOut : null
/// location_checkOut : null

class Message {
  Message({
      int? id, 
      dynamic checkOut, 
      dynamic locationCheckOut,}){
    _id = id;
    _checkOut = checkOut;
    _locationCheckOut = locationCheckOut;
}

  Message.fromJson(dynamic json) {
    _id = json['id'];
    _checkOut = json['checkOut'];
    _locationCheckOut = json['location_checkOut'];
  }
  int? _id;
  dynamic _checkOut;
  dynamic _locationCheckOut;

  int? get id => _id;
  dynamic get checkOut => _checkOut;
  dynamic get locationCheckOut => _locationCheckOut;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['checkOut'] = _checkOut;
    map['location_checkOut'] = _locationCheckOut;
    return map;
  }

}