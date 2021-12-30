class BreedingData {
  BreedingData({
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

  BreedingData.fromJson(dynamic json) {
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
  final String breedingID;
  final String breedingName;
  final String status;
  final String typeName;
  final String breedingDetail;
  final String date;

  const Data(
      {required this.breedingID,
      required this.breedingName,
      required this.status,
      required this.typeName,
      required this.breedingDetail,
      required this.date});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        breedingID: json['breedingID'],
        breedingName: json['breedingName'],
        status: json['status'],
        typeName: json['typeName'],
        breedingDetail: json['breedingDetail'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['breedingID'] = this.breedingID;
    data['breedingName'] = this.breedingName;
    data['status'] = this.status;
    data['typeName'] = this.typeName;
    data['breedingDetail'] = this.breedingDetail;
    data['date'] = this.date;
    return data;
  }
}
