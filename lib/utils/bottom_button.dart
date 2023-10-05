import 'package:firebase_crud_example/utils/constants.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String buttonTitle;

  const BottomButton({
    super.key,
    required this.onPress,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 50,
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x5a8c9eff),
                spreadRadius: 10,
                blurRadius: 40,
                offset: Offset(0, 12),
              ),
            ],
            gradient: kGradient,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Center(
          child: Text(
            buttonTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
