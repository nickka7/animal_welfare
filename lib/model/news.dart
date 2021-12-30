class NewsData {
  NewsData({
    String? resultCode,
    String? status,
    dynamic errorMessage,
    List<Data>? data,
  }) {
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _data = data;
  }

  NewsData.fromJson(dynamic json) {
    _resultCode = json['resultCode'];
    _status = json['status'];
    _errorMessage = json['errorMessage'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _resultCode;
  String? _status;
  dynamic _errorMessage;
  List<Data>? _data;

  String? get resultCode => _resultCode;
  String? get status => _status;
  dynamic get errorMessage => _errorMessage;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resultCode'] = _resultCode;
    map['status'] = _status;
    map['errorMessage'] = _errorMessage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    String? title,
    String? detail,
    String? image,
  }) {
    _title = title;
    _detail = detail;
    _image = image;
  }

  Data.fromJson(dynamic json) {
    _title = json['title'];
    _detail = json['detail'];
    _image = json['image'];
  }
  String? _title;
  String? _detail;
  String? _image;

  String? get title => _title;
  String? get detail => _detail;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['detail'] = _detail;
    map['image'] = _image;
    return map;
  }
}
