import 'package:flutter/material.dart';

import 'constants.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final Widget icon;
  final TextFieldTypes type;

  const RoundedTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: const BoxDecoration(
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
      ),
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          child: TextField(
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
            obscureText: type == TextFieldTypes.password,
            keyboardType: type == TextFieldTypes.email
                ? TextInputType.emailAddress
                : TextInputType.text,
            onChanged: (value) {},
            decoration: kTextFiledInputDecoration.copyWith(
              hintText: hintText,
              prefixIcon: ShaderMask(
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
