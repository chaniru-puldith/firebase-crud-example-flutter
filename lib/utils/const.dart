import 'package:flutter/material.dart';

const kTextFiledInputDecoration = InputDecoration(
  hintText: 'Enter Text',
  hintStyle: TextStyle(fontStyle: FontStyle.italic),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 3),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
