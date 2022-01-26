
import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/material.dart';

class ModifyMyContact extends StatefulWidget {
  const ModifyMyContact({ Key? key }) : super(key: key);

  @override
  _ModifyMyContactState createState() => _ModifyMyContactState();
}

class _ModifyMyContactState extends State<ModifyMyContact> {
  var _controller = TextEditingController();
  var _controller2 = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F7F7F7"),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
        color: HexColor("#697825")
        ),
        ),
          centerTitle: true,
          title: Text('ข้อมูลส่วนตัว',
          style: const TextStyle(color: Colors.white)   
      ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: double.infinity,
        // color: Colors.black,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 30,
                  // color: Colors.black,
                  // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      Icon(Icons.edit_outlined,
                      color: HexColor("#697825")),
                      Text('   แก้ไขข้อมูลการติดต่อ',
                      style: TextStyle(
                        color: HexColor("#697825"),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        ),
                        ),
                        
                      // TextField(
                      //   decoration: InputDecoration(
                      //     prefix: Image.asset('icontaps/heart.png'),
                      //     labelText: '   แก้ไขชื่อ - สกุล',
                      //     labelStyle: TextStyle(fontSize: 18)
                      //   ),
                      // )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                  border: Border.all(color: HexColor("#BEBEBE")),
                  color: HexColor("#FFFFFF"),
                  borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                    child: Container(
                      child: 
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text('E-mail :',
                        //   style: TextStyle(
                        //           color: Colors.black,
                        //           fontSize: 16.0,
                        //           fontWeight: FontWeight.w500),
                        //         ),
                        // ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: Image.asset('icontaps/xrepair.png'),
                          
                          
                        // ),
                        TextFormField(
                  controller:_controller,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    suffixIcon: IconButton(
                      onPressed: (){
                        _controller.clear();
                      },
                      icon: Icon(
                      Icons.cancel_outlined,
                      color: HexColor("#697825")
                    ),
                    ),

                  ),
                ),

  //               TextFormField(
  //   autofocus: false,
  //   obscureText: true,
  //   decoration: InputDecoration(
  //      labelText: 'Password',
  //      suffixIcon: Icon(
  //                   Icons.clear,
  //                   size: 20.0,
  //                 ),
  //      border: OutlineInputBorder(
  //      borderRadius: BorderRadius.all(Radius.circular(0.0)),
  //    ),
  //     hintText: 'Enter Password',
  //     contentPadding: EdgeInsets.all(10.0),
  //   ),
  // ),
                        
                      // ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                  border: Border.all(color: HexColor("#BEBEBE")),
                  color: HexColor("#FFFFFF"),
                  borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                    child: Stack(
                      children: [
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text('Line ID :',
                        //   style: TextStyle(
                        //           color: Colors.black,
                        //           fontSize: 16.0,
                        //           fontWeight: FontWeight.w500),
                        //         ),
                        // ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: Image.asset('icontaps/xrepair.png'),
                        // ),
                        TextFormField(
                  controller:_controller2,
                  decoration: InputDecoration(
                    hintText: "LineID",
                    suffixIcon: IconButton(
                      onPressed: (){
                        _controller2.clear();
                      },
                      icon: Icon(
                      Icons.cancel_outlined,
                      color: HexColor("#697825")
                    ),
                    ),

                  ),
                ),
                      ],
                    ),
                  ),
                ),

              ],              
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 4.0,)]
                    ),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      // textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                        color: HexColor("#697825"),
                        child: Text('บันทึก',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          )
                          ),
                          onPressed: (){
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(getData: widget.getData, )));
                            },
                      ),
                ),
             ),
          ],
        ),
        
      ),
      
    );
  }
}