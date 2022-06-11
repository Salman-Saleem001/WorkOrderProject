import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workorder/Screens/StatusScreen.dart';

import '../Services/AuthenticationServices.dart';
import '../Style/TextFieldStyle.dart';
import '../Style/TextFieldTextStyle.dart';
import '../Utils/AppBar.dart';

class OptionSelectionScreen extends StatefulWidget {
  final String city;
  const OptionSelectionScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<OptionSelectionScreen> createState() => _OptionSelectionState();
}

class _OptionSelectionState extends State<OptionSelectionScreen> {
  final database = FirebaseDatabase.instance;
  final AuthenticationService authCheck = AuthenticationService();
  final _formkey = GlobalKey<FormState>();
  String dropdownvalue = 'Select Option';
  String? userId = AuthenticationService().getUserId();
  String check = '';
  String name = '';
  String number = '';
  String discription = '';

  // List of items in our dropdown menu
  var items = [
    'Select Option',
    'Damage',
    'Missing Parts',
    'Others',
  ];
  @override
  Widget build(BuildContext context) {
    final userRef = database.ref().child('users/' + userId!);
    return Scaffold(
      appBar: getAppBar(title: 'Get What You Want!!', context: context),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Text(
                  "Select the required Option :",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: Colors.grey),
                ),
              ),
              DropdownButton(
                isExpanded: true,
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    check = dropdownvalue;
                  });
                },
              ),
              Form(
                key: _formkey,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Name',
                        style: getTextStyle(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 70,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Name cannot be empty' : null,
                        onChanged: (val) {
                          name = val;
                        },
                        keyboardType: TextInputType.text,
                        decoration: getOutlineBorderDecoration(
                          hintText: 'Enter Your Name',
                          prefixicon: Icons.person_outline,
                          focusColor: 0xff555555,
                          enabledColor: 0xff555555,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Text(
                        'Phone Number',
                        style: getTextStyle(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 70,
                      ),
                      TextFormField(
                        validator: (val) => val!.isEmpty
                            ? 'phone number cannot be empty'
                            : null,
                        onChanged: (val) {
                          number = val;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: getOutlineBorderDecoration(
                          hintText: 'Enter Your Phone Number',
                          prefixicon: Icons.phone_outlined,
                          focusColor: 0xff555555,
                          enabledColor: 0xff555555,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Text(
                        'Discription Box :',
                        style: getTextStyle(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 70,
                      ),
                      TextFormField(
                        maxLines: 4,
                        validator: (val) =>
                            val!.isEmpty ? 'Discripton is required' : null,
                        onChanged: (val) {
                          discription = val;
                        },
                        keyboardType: TextInputType.text,
                        decoration: getOutlineBorderDecoration(
                          hintText: 'Discription',
                          focusColor: 0xff555555,
                          enabledColor: 0xff555555,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.5,
              ),
              FlatButton(
                minWidth: double.infinity,
                height: MediaQuery.of(context).size.height / 20,
                disabledColor: Colors.blue.withOpacity(.5),
                onPressed: check.isEmpty || check == "Select Option"
                    ? null
                    : () async {
                        await userRef
                            .set({
                              'full_name': name,
                              'city': widget.city,
                              'number': number,
                              'option': check,
                              'discription': discription,
                              'status': 'Not Started',
                            })
                            .then(
                              (value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StatusScreen(),
                                ),
                              ),
                            )
                            .catchError((error) => print('There was an Error'));
                      },
                child: Text(
                  "Place Order",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                textColor: Colors.white,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Center(
                child: Text(
                  'The provided information must be correct',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
