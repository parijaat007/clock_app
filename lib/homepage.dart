import 'package:clock_app/clockview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    var timeFormatted = DateFormat('hh:mm:ssa').format(time);
    //var AMPMFormat = DateFormat('HH').format(time);
    //https://pub.dev/packages/intl
    var dateFormatted = DateFormat('EEE, d MMM').format(time);
    var timeZone = time.timeZoneOffset.toString().split('.').first;
    var offset = '';
    var AMPM = 'AM';
    
    //bool flag = AMPMFormat.isAfter(DateFormat('HH').for);
    //if (AMPMFormat.isAfter(12)) AMPM = 'PM';
    if (!timeZone.startsWith('-')) offset = '+';
    return Scaffold(
      backgroundColor: Color(0xFF0C0C0C),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(50),
              //symmetric(horizontal: 30, vertical: 60),
              //alignment: Alignment.center,
              color: Color(0xFF1C1C1C),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text('Clock',
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Text(timeFormatted,
                        style: TextStyle(color: Colors.white, fontSize: 50)),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Text(dateFormatted,
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                  ),
                  ClockView(),
                  Text('Timezone',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(Icons.language, color: Colors.white),
                      SizedBox(height: 10),
                      Text('UTC' + offset + timeZone,
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),

          ),
          Divider(
            color: Color(0xFF5C5C5C),
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      FlutterLogo(),
                      Text(
                        'Clock',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ))
            ],
          ),

        ],
      ),
    );
  }
}
