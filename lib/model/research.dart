class ResearchData {
  ResearchData({
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

  ResearchData.fromJson(dynamic json) {
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
  final String researchID;
  final String researchName;
  final String typeName;
  final String researchDetail;
  final String date;

  const Data(
      {required this.researchID,
      required this.researchName,
      required this.typeName,
      required this.researchDetail,
      required this.date});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        researchID: json['researchID'],
        researchName: json['breedingName'],
        typeName: json['typeName'],
        researchDetail: json['researchDetail'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['researchID'] = this.researchID;
    data['researchName'] = this.researchName;
    data['typeName'] = this.typeName;
    data['researchDetail'] = this.researchDetail;
    data['date'] = this.date;
    return data;
  }
}
