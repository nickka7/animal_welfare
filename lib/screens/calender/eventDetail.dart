import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//หน้ารายละเอียดกิจกรรมและงาน
class EventDetail extends StatefulWidget {
  final String subject;
  final String? location;
  final DateTime start;
  final DateTime end;
  const EventDetail({Key? key, required this.subject,this.location,required  this.start,required  this.end}) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
   
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'รายละเอียดกิจกรรม',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [_buildfont('ชื่อกิจกรรม :', '${widget.subject}'),
            _buildfont('สถานที่ :', '${widget.location}'),
            _buildfont('เวลาเริ่ม :', ' ${DateFormat('dd/mm/yy hh:mm a').format(widget.start)}'),
            _buildfont('ถึง :', '${DateFormat('dd/mm/yy hh:mm a').format(widget.end)}')],
          ),
        ),
      ),
    );
  }

// TextStyle สีข้อความ ขนาดข้อความ
  Widget _buildfont(var title, var data) {
    return Container(
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            data,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
