import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_example/utils/constants.dart';
import 'package:firebase_crud_example/utils/bottom_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance;
  late AnimationController animationController;
  late Animation animation;
  bool _isPasswordHidden = true;
  String? _email;
  String? _password;

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

  Future<String> login(
      {required String email, required String password}) async {
    String message;
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _auth.authStateChanges().listen((User? user) async {
        if (user != null) {
          DatabaseReference ref = _database.ref("users/${user.uid}");
          await ref
              .set({"uid": user.uid, "email": email, "password": password});
        }
      });

      message = 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'Email Not Registered';
      } else if (e.code == 'wrong-password') {
        message = 'Invalid Credentials';
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        message = 'Invalid Credentials';
      } else {
        message = 'Unexpected Error';
      }
    }
    Navigator.of(context).pop();
    return message;
  }

  void displaySnackBar({required String message, required SnackBarType type}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: type == SnackBarType.error
                    ? Colors.red.withOpacity(0.1)
                    : Colors.green.withOpacity(0.1),
                spreadRadius: 10,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                type == SnackBarType.error
                    ? Icons.error_outline
                    : Icons.check_circle_outline,
                size: 32,
                color: type == SnackBarType.error ? Colors.red : Colors.green,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      type == SnackBarType.error ? "Error" : "Success",
                      style: TextStyle(
                        fontSize: 18,
                        color: type == SnackBarType.error
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  String? _isInvalid() {
    if (_email == null ||
        _password == null ||
        _email!.isEmpty ||
        _password!.isEmpty) {
      return ('Email and Password can\'t be empty');
    } else if (!EmailValidator.validate(_email!)) {
      return ('Invalid Email Address');
    } else {
      bool hasUppercase = _password!.contains(RegExp(r'[A-Z]'));
      bool hasDigits = _password!.contains(RegExp(r'[0-9]'));
      bool hasLowercase = _password!.contains(RegExp(r'[a-z]'));
      bool hasSpecialCharacters =
          _password!.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      bool hasMinLength = _password!.length > 8;

      if (hasUppercase &&
          hasDigits &&
          hasLowercase &&
          hasSpecialCharacters &&
          hasMinLength) {
        return null;
      } else {
        return 'Password should contain at least 8 characters with at least one a-z, A-Z, 0-9 and special character';
      }
    }
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
              child: Padding(
                padding: const EdgeInsets.all(10),
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
                      size: 30,
                    ),
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
                      'Log In',
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
                    'Enter your credentials',
                    style: TextStyle(
                      color: Colors.blueGrey.withOpacity(0.7),
                      fontSize: 18,
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: kTextFormFieldOuterContainerStyle,
                      child: Center(
                        child: TextField(
                          style: kTextFormFieldStyle,
                          keyboardType: TextInputType.emailAddress,
                          decoration: kTextFiledInputDecoration.copyWith(
                            hintText: 'e-mail',
                            prefixIcon: kGradientEmailIcon,
                          ),
                          onChanged: (value) {
                            _email = value;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: kTextFormFieldOuterContainerStyle,
                      child: Center(
                        child: TextField(
                          obscureText: _isPasswordHidden,
                          style: kTextFormFieldStyle,
                          decoration: kTextFiledInputDecoration.copyWith(
                            hintText: 'password',
                            prefixIcon: kGradientPasswordIcon,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordHidden = !_isPasswordHidden;
                                });
                              },
                              icon: _isPasswordHidden
                                  ? kGradientNotVisibleIcon
                                  : kGradientVisibleIcon,
                            ),
                          ),
                          onChanged: (value) {
                            _password = value;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    BottomButton(
                      onPress: () async {
                        String? error = _isInvalid();
                        if (error == null) {
                          var response =
                              await login(email: _email!, password: _password!);
                          response == 'Success'
                              ? displaySnackBar(
                                  message: response, type: SnackBarType.success)
                              : displaySnackBar(
                                  message: response, type: SnackBarType.error);
                        } else {
                          displaySnackBar(
                              message: error, type: SnackBarType.error);
                        }
                      },
                      buttonTitle: 'Log In ➜',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.blueGrey.withOpacity(0.5),
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
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
