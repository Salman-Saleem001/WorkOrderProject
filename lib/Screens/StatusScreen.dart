import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Services/AuthenticationServices.dart';
import '../Style/AppBarStyle.dart';
import '../Utils/AppBar.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  List<String> label = ['Not Started', 'In Progress', 'Finished'];
  int count = 1;
  String? Id = AuthenticationService().getUserId();
  final databaseRef = FirebaseDatabase.instance.ref();
  late StreamSubscription _streamSubscription;
  void initState() {
    super.initState();
    fetchDatafromList();
  }

  fetchDatafromList() async {
    _streamSubscription =
        databaseRef.child('users/${Id!}/status').onValue.listen((event) {
      final String? userData = event.snapshot.value as String?;
      if (userData == null) {
        print('Error');
      } else {
        print(userData);
        if (userData == 'Not Started') {
          setState(() {
            count = 1;
          });
        } else if (userData == 'In Progress') {
          setState(() {
            count = 2;
          });
        } else {
          setState(() {
            count = 3;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(title: 'Status of your order', context: context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 30,
            ),
            StepProgressIndicator(
              roundedEdges: Radius.circular(20),
              totalSteps: 3,
              currentStep: count,
              size: 36,
              selectedColor: Colors.blue,
              unselectedColor: Colors.black12,
              customStep: (index, color, _) => color == Colors.blue
                  ? Container(
                      color: color,
                      child: Center(
                        child: Text(
                          label[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Container(
                      color: color,
                      child: Center(
                        child: Text(
                          label[index],
                        ),
                      )),
            ),
            Container(
                child: count == 3
                    ? Text(
                        'Your Order Has been Delivered !!!',
                        style: getAppBarTextStyle(),
                      )
                    : null),
          ],
        ),
      ),
    );
  }

  void deactivate() {
    _streamSubscription.cancel();
    super.deactivate();
  }
}
