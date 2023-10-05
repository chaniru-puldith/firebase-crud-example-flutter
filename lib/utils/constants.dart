import 'package:flutter/material.dart';

enum TextFieldTypes { password, email }

const kTextFiledInputDecoration = InputDecoration(
    hintText: 'Enter Text',
    hintStyle: TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(borderSide: BorderSide.none)
    // enabledBorder: OutlineInputBorder(
    //   borderSide: BorderSide.none,
    // ),
    // focusedBorder: OutlineInputBorder(
    //   borderSide: BorderSide(color: Colors.black12, width: 1),
    //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
    // ),
    );

const kGradient = LinearGradient(colors: [Colors.purple, Colors.blue]);
