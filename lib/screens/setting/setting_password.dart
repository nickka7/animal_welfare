import 'package:animal_welfare/haxColor.dart';
import 'package:flutter/material.dart';

class SettingPassword extends StatefulWidget {
  const SettingPassword({ Key? key }) : super(key: key);

  @override
  _SettingPasswordState createState() => _SettingPasswordState();
}

class _SettingPasswordState extends State<SettingPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[HexColor("#697825"), HexColor("#FFFFFF")]
              ),
              ),
              child: 
              // Column(
              //   children: [
              //     Center(
              //       child: Container(
              //                     margin: EdgeInsets.all(30),
              //                     width: 200.0,
              //                     height: 200.0,
              //                     decoration: BoxDecoration(
              //                       shape: BoxShape.circle,
              //                                                         //  image: DecorationImage(
              //                                       // fit: BoxFit.fill,
              //                       color: Colors.black45,
              //                         //image: NetworkImage('${dataWorld[i].countryInfo.flag}')
              //                     )
              //                   ),
              //     ),
                  OtpScreen(),
              //   ],
              // ),
      )
      
    );
  }
}

class OtpScreen extends StatefulWidget {

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  List<String> currentPin = ["","","","","",""];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  TextEditingController pinFiveController = TextEditingController();
  TextEditingController pinSixController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.black12)
  );

  int pinIndex = 0;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Center(
                    child: Container(
                                  margin: EdgeInsets.all(30),
                                  width: 200.0,
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                                                      //  image: DecorationImage(
                                                    // fit: BoxFit.fill,
                                    color: Colors.black45,
                                      //image: NetworkImage('${dataWorld[i].countryInfo.flag}')
                                  )
                                ),
                  ),
          // buildExitButton(),
          // Expanded(
            // child: 
            Container(
              alignment: Alignment(0, 0.5),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildSecurityText(),
                  SizedBox(height: 20.0),
                  buildPinRow(),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          // ),
          buildNumberPad(),
        ],
      ),
    );
  }

  buildNumberPad(){
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n: 1,
                    onPressed: () {
                      pinIndexSetup('1');
                    }
                  ),
                  KeyboardNumber(
                    n: 2,
                    onPressed: () {
                      pinIndexSetup('2');
                    }
                  ),
                  KeyboardNumber(
                    n: 3,
                    onPressed: () {
                      pinIndexSetup('3');
                    }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n: 4,
                    onPressed: () {
                      pinIndexSetup('4');
                    }
                  ),
                  KeyboardNumber(
                    n: 5,
                    onPressed: () {
                      pinIndexSetup('5');
                    }
                  ),
                  KeyboardNumber(
                    n: 6,
                    onPressed: () {
                      pinIndexSetup('6');
                    }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n: 7,
                    onPressed: () {
                      pinIndexSetup('7');
                    }
                  ),
                  KeyboardNumber(
                    n: 8,
                    onPressed: () {
                      pinIndexSetup('8');
                    }
                  ),
                  KeyboardNumber(
                    n: 9,
                    onPressed: () {
                      pinIndexSetup('9');
                    }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 60.0,
                    child: MaterialButton(
                      onPressed: null,
                      child: SizedBox(),
                      ),
                  ),
                  KeyboardNumber(
                    n: 0,
                    onPressed: () {
                      pinIndexSetup('0');
                    }
                  ),
                  Container(
                    width: 60,
                    child: MaterialButton(
                      height: 60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      onPressed: () {
                        clearPin();
                      },
                      child: Icon(
                        Icons.backspace_outlined,
                        size: 30,),
                    ),
                    
                  ),
                ],
              ),
            ],
          ),
          ),
      ),
      );
  }

  clearPin() {
    if (pinIndex == 0)
      pinIndex = 0;
    else if (pinIndex == 6) {
      setPin(pinIndex, '');
      currentPin[pinIndex - 1] = '';
      pinIndex--;
    } else {
      setPin(pinIndex, '');
      currentPin[pinIndex - 1] = '';
      pinIndex--;
    }
  }

  pinIndexSetup(String text) {
    if(pinIndex == 0)
      pinIndex = 1;
    else if(pinIndex < 6)
      pinIndex++;
    setPin(pinIndex, text);
    currentPin[pinIndex-1] = text;
    String strPin = '';
    currentPin.forEach((e) {
      strPin += e;
    });
    if(pinIndex == 6)
    print(strPin);
  }

  setPin (int n,String text) {
    switch (n) {
      case 1:
        pinOneController.text = text;
        break;
      case 2:
        pinTwoController.text = text;
        break;
      case 3:
        pinThreeController.text = text;
        break;
      case 4:
        pinFourController.text = text;
        break;
      case 5:
        pinFiveController.text = text;
        break;
      case 6:
        pinSixController.text = text;
        break;
        
    }
    
  }

  buildPinRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinOneController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinTwoController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinThreeController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFourController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFiveController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinSixController,
        ),
      ],
    );
  }

  buildSecurityText(){
    return Text(
      'กรุณาใส่ PIN',
      style: TextStyle(
        color: Colors.black,
        fontSize: 21,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  buildExitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {},
            height: 50.0,
            minWidth: 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0)
            ),
            child: Icon(Icons.clear, color: Colors.white),
            ),
        ),
      ],
    );
  }


}

class PINNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;
  PINNumber({required this.textEditingController,required this.outlineInputBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          border: outlineInputBorder,
          filled: true,
          fillColor: Colors.black12,
        ),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
    );
  }
}

class KeyboardNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;
  KeyboardNumber({required this.n, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        border: Border.all(color: HexColor("#697825")),
        shape: BoxShape.circle,
        color: Colors.white70,
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: EdgeInsets.all(8.0),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0)
        ),
        height: 90.0,
        child: Text('$n',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24 * MediaQuery.of(context).textScaleFactor,
          color: Colors.black,

        )
      ),
      )
      
    );
  }
}