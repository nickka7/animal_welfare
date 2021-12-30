import 'dart:core';

class WeatherData {
  WeatherData({
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

  WeatherData.fromJson(dynamic json) {
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
    int? temperature,
    int? airpressure,
    int? moisture,
  }) {
    _temperature = temperature;
    _airpressure = airpressure;
    _moisture = moisture;
  }

  Data.fromJson(dynamic json) {
    _temperature = json['temperature'];
    _airpressure = json['airpressure'];
    _moisture = json['moisture'];
  }
  int? _temperature;
  int? _airpressure;
  int? _moisture;

  int? get temperature => _temperature;
  int? get airpressure => _airpressure;
  int? get moisture => _moisture;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['temperature'] = _temperature;
    map['airpressure'] = _airpressure;
    map['moisture'] = _moisture;
    return map;
  }
}

