// To parse this JSON data, do
//
//     final historyBooking = historyBookingFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

HistoryBooking historyBookingFromJson(String str) => HistoryBooking.fromJson(json.decode(str));

String historyBookingToJson(HistoryBooking data) => json.encode(data.toJson());

class HistoryBooking {
    HistoryBooking({
        required this.status,
        required this.message,
    });

    final String status;
    final List<Message> message;

    factory HistoryBooking.fromJson(Map<String, dynamic> json) => HistoryBooking(
        status: json["status"],
        message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
    };
}

class Message {
    Message({
        required this.bookingId,
        required this.requestId,
        required this.requestName,
        required this.requestRole,
        required this.build,
        required this.room,
        required this.time,
        required this.status,
    });

    final String bookingId;
    final String requestId;
    final String requestName;
    final String requestRole;
    final String build;
    final String room;
    final String time;
    final String status;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        bookingId: json["bookingID"],
        requestId: json["requestID"],
        requestName: json["requestName"],
        requestRole: json["requestRole"],
        build: json["build"],
        room: json["room"],
        time: json["time"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "bookingID": bookingId,
        "requestID": requestId,
        "requestName": requestName,
        "requestRole": requestRole,
        "build": build,
        "room": room,
        "time": time,
        "status": status,
    };
}
