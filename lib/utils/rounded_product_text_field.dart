import 'package:flutter/material.dart';

import 'constants.dart';

class RoundedProductTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;

  const RoundedProductTextField({
    super.key,
    required this.hintText,
    required this.labelText,
  });

  @override
  State<RoundedProductTextField> createState() =>
      _RoundedProductTextFieldState();
}

class _RoundedProductTextFieldState extends State<RoundedProductTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    _textEditingController.text = widget.labelText!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.labelText);
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
              hintText: widget.hintText,
            ),
            controller: _textEditingController,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
