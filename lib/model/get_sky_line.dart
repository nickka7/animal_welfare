
class GetFlightArea {


  double? _latitude;
  double? _longitude;
  int? _radiusKm;
  int? _totalFlight;
  List<Flights>? _flights;

  double? get latitude => _latitude;
  double? get longitude => _longitude;
  int? get radiusKm => _radiusKm;
  int? get totalFlight => _totalFlight;
  List<Flights>? get flights => _flights;

  GetFlightArea({
      double? latitude, 
      double? longitude, 
      int? radiusKm, 
      int? totalFlight, 
      List<Flights>? flights}){
    _latitude = latitude;
    _longitude = longitude;
    _radiusKm = radiusKm;
    _totalFlight = totalFlight;
    _flights = flights;
}

  GetFlightArea.fromJson(dynamic json) {
    _latitude = json["latitude"];
    _longitude = json["longitude"];
    _radiusKm = json["radius_km"];
    _totalFlight = json["total_flight"];
    if (json["flights"] != null) {
      _flights = [];
      json["flights"].forEach((v) {
        _flights?.add(Flights.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["latitude"] = _latitude;
    map["longitude"] = _longitude;
    map["radius_km"] = _radiusKm;
    map["total_flight"] = _totalFlight;
    if (_flights != null) {
      map["flights"] = _flights?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// airline : "MMA"
/// altitude : 37000
/// arrival : "KUL"
/// arrival_position : [2.74558,101.71]
/// departure : "RGN"
/// departure_position : [16.9073,96.1332]
/// flight : "8M5001"
/// groundspeed : 460
/// heading : 160
/// latitude : 8.5112
/// longitude : 100.19471
/// registration : "XY-ALL"
/// source : "ADSB"
/// station : "PGANRB501023"
/// timestamp : 1625028649045
/// type : "A320"
/// verticalspeed : ""

class Flights {
  String? _airline;
  int? _altitude;
  String? _arrival;
  List<double>? _arrivalPosition;
  String? _departure;
  List<double>? _departurePosition;
  String? _flight;
  // double? _groundspeed;
  // double? _heading;
  double? _latitude;
  double? _longitude;
  String? _registration;
  String? _source;
  String? _station;
  int? _timestamp;
  String? _type;
  // String? _verticalspeed;

  String? get airline => _airline;
  int? get altitude => _altitude;
  String? get arrival => _arrival;
  List<double>? get arrivalPosition => _arrivalPosition;
  String? get departure => _departure;
  List<double>? get departurePosition => _departurePosition;
  String? get flight => _flight;
  // double? get groundspeed => _groundspeed;
  // double? get heading => _heading;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  String? get registration => _registration;
  String? get source => _source;
  String? get station => _station;
  int? get timestamp => _timestamp;
  String? get type => _type;
  // String? get verticalspeed => _verticalspeed;

  Flights({
      String? airline, 
      int? altitude, 
      String? arrival, 
      List<double>? arrivalPosition, 
      String? departure, 
      List<double>? departurePosition, 
      String? flight, 
      // double? groundspeed,
      // double? heading,
      double? latitude, 
      double? longitude, 
      String? registration, 
      String? source, 
      String? station, 
      int? timestamp, 
      String? type, 
      // String? verticalspeed
  }){
    _airline = airline;
    _altitude = altitude;
    _arrival = arrival;
    _arrivalPosition = arrivalPosition;
    _departure = departure;
    _departurePosition = departurePosition;
    _flight = flight;
    // _groundspeed = groundspeed;
    // _heading = heading;
    _latitude = latitude;
    _longitude = longitude;
    _registration = registration;
    _source = source;
    _station = station;
    _timestamp = timestamp;
    _type = type;
    // _verticalspeed = verticalspeed;
}

  Flights.fromJson(dynamic json) {
    _airline = json["airline"];
    _altitude = json["altitude"];
    _arrival = json["arrival"];
    _arrivalPosition = json["arrival_position"] != null ? json["arrival_position"].cast<double>() : [];
    _departure = json["departure"];
    _departurePosition = json["departure_position"] != null ? json["departure_position"].cast<double>() : [];
    _flight = json["flight"];
    // _groundspeed = json["groundspeed"].cast<double>();
    // _heading = json["heading"];
    _latitude = json["latitude"];
    _longitude = json["longitude"];
    _registration = json["registration"];
    _source = json["source"];
    _station = json["station"];
    _timestamp = json["timestamp"];
    _type = json["type"];
    // _verticalspeed = json["verticalspeed"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["airline"] = _airline;
    map["altitude"] = _altitude;
    map["arrival"] = _arrival;
    map["arrival_position"] = _arrivalPosition;
    map["departure"] = _departure;
    map["departure_position"] = _departurePosition;
    map["flight"] = _flight;
    // map["groundspeed"] = _groundspeed;
    // map["heading"] = _heading;
    map["latitude"] = _latitude;
    map["longitude"] = _longitude;
    map["registration"] = _registration;
    map["source"] = _source;
    map["station"] = _station;
    map["timestamp"] = _timestamp;
    map["type"] = _type;
    // map["verticalspeed"] = _verticalspeed;
    return map;
  }

}