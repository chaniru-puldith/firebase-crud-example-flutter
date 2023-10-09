import 'package:flutter/material.dart';

import 'gradient_icon.dart';

enum TextFieldTypes { password, email }

enum SnackBarType { error, success }

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

ShaderMask buildGradientIcon(Widget icon) {
  return ShaderMask(
    blendMode: BlendMode.srcIn,
    shaderCallback: (Rect bounds) => const RadialGradient(
      center: Alignment.topCenter,
      stops: [.5, 1],
      colors: [
        Colors.blue,
        Colors.purple,
      ],
    ).createShader(bounds),
    child: icon,
  );
}

const kTextFormFieldOuterContainerStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(100)),
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(
        67,
        71,
        77,
        0.08,
      ),
      spreadRadius: 10,
      blurRadius: 40,
      offset: Offset(0, 12),
    ),
  ],
);

const kTextFormFieldStyle = TextStyle(
  fontSize: 18,
  fontStyle: FontStyle.italic,
);

const kGradientEmailIcon = GradientIcon(icon: Icon(Icons.email_outlined));
const kGradientPasswordIcon = GradientIcon(icon: Icon(Icons.key_off_outlined));
const kGradientVisibleIcon = GradientIcon(icon: Icon(Icons.visibility));
const kGradientNotVisibleIcon = GradientIcon(icon: Icon(Icons.visibility_off));
