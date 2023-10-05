import 'package:firebase_crud_example/utils/constants.dart';
import 'package:firebase_crud_example/utils/bottom_button.dart';
import 'package:flutter/material.dart';

import '../utils/rounded_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    animation =
        CurvedAnimation(parent: animationController, curve: Curves.decelerate);

    animationController.forward();

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {},
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) => const RadialGradient(
                    center: Alignment.topCenter,
                    stops: [.5, 1],
                    colors: [
                      Colors.blue,
                      Colors.purple,
                    ],
                  ).createShader(bounds),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 40,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) =>
                        kGradient.createShader(bounds),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: animation.value * 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Create your account',
                    style: TextStyle(
                      color: Colors.blueGrey.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const RoundedTextField(
                      hintText: 'e-mail',
                      icon: Icon(
                        Icons.email_outlined,
                      ),
                      type: TextFieldTypes.email,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const RoundedTextField(
                      hintText: 'password',
                      icon: Icon(Icons.key_off_outlined),
                      type: TextFieldTypes.password,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const RoundedTextField(
                      hintText: 'confirm password',
                      icon: Icon(Icons.key_off_outlined),
                      type: TextFieldTypes.password,
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    BottomButton(
                      onPress: () {},
                      buttonTitle: 'Sign Up ➜',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                              color: Colors.blueGrey.withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Login'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
