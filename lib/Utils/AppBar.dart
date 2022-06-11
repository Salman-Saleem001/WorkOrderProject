import 'package:flutter/material.dart';
import 'package:workorder/Screens/StatusScreen.dart';
import 'package:workorder/Services/AuthenticationServices.dart';

import '../Style/AppBarStyle.dart';

AppBar getAppBar({String? title, context}) {
  AuthenticationService authenticationService = AuthenticationService();
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text(
      title!,
      style: getAppBarTextStyle(),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: title != 'Status of your order'
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatusScreen(),
                    ),
                  );
                },
                child: Text(
                  'Status',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              )
            : null,
      ),
      IconButton(
        onPressed: () {
          authenticationService.signOut();
        },
        icon: Icon(
          Icons.logout,
          color: Colors.white,
        ),
      )
    ],
  );
}
