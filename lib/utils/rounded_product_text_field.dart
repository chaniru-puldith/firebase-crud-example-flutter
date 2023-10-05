import 'package:flutter/material.dart';

import 'constants.dart';

class RoundedProductTextField extends StatelessWidget {
  final String hintText;

  const RoundedProductTextField({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20, top: 5),
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
            onChanged: (value) {},
            decoration: kTextFiledInputDecoration.copyWith(
              hintText: hintText,
            ),
          ),
        ),
      ),
    );
  }
}
