/// resultCode : "200"
/// status : "SUCCESS"
/// errorMessage : null
/// data : [{"documentName":"คู่มือเข้าชมสวนสัตว์","url":"http://192.168.1.106:3000/Report.pdf"},{"documentName":"เผยแพร่แผนจัดซื้อจัดจ้าง","url":"http://192.168.1.106:3000/Test.docx"},{"documentName":"Report.pdf","url":"http://192.168.1.106:3000/Report.pdf"},{"documentName":"animal","url":"http://192.168.1.106:3000/Report.pdf"},{"documentName":"animal","url":"http://192.168.1.106:3000/Report.pdf"},{"documentName":"animal","url":"http://192.168.1.106:3000/animal.xlsx"},{"documentName":"animal","url":"http://192.168.1.106:3000/Report.pdf"},{"documentName":"animal.xlsx","url":"http://192.168.1.106:3000/animal.xlsx"},{"documentName":"Report.pdf","url":"http://192.168.1.106:3000/Report.pdf"},{"documentName":"animal.xlsx","url":"http://192.168.1.106:3000/animal.xlsx"},{"documentName":"Report.pdf","url":"http://192.168.1.106:3000/Report.pdf"}]

class Document {
  Document({
      String? resultCode, 
      String? status, 
      dynamic errorMessage, 
      List<Data>? data,}){
    _resultCode = resultCode;
    _status = status;
    _errorMessage = errorMessage;
    _data = data;
}

  Document.fromJson(dynamic json) {
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

/// documentName : "คู่มือเข้าชมสวนสัตว์"
/// url : "http://192.168.1.106:3000/Report.pdf"

class Data {
  Data({
      String? documentName, 
      String? url,}){
    _documentName = documentName;
    _url = url;
}

  Data.fromJson(dynamic json) {
    _documentName = json['documentName'];
    _url = json['url'];
  }
  String? _documentName;
  String? _url;

  String? get documentName => _documentName;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['documentName'] = _documentName;
    map['url'] = _url;
    return map;
  }

}