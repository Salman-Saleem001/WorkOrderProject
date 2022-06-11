import 'package:flutter/material.dart';

InputDecoration getOutlineBorderDecoration({
  String? hintText = '',
  IconData? prefixicon = null,
  IconData? suffixicon = null,
  int? focusColor = 0xffffffff,
  int? enabledColor = 0xffffffff,
}) {
  return InputDecoration(
    hintText: hintText,
    errorStyle: TextStyle(
      color: Colors.red.shade300,
    ),
    hintStyle: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: Colors.white,
    ),
    prefixIcon: prefixicon != null
        ? Icon(
            prefixicon,
            color: Colors.black,
          )
        : null,
    border: InputBorder.none,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: Color(focusColor!),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: Color(enabledColor!),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red.shade300,
        width: 1.0,
      ),
    ),
  );
}
