import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_example/utils/constants.dart';
import 'package:firebase_crud_example/utils/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance;
  late AnimationController _animationController;
  late Animation _animation;
  String? _email;
  String? _password;
  String? _confirmPassword;
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  Future<void> register(
      {required String email, required String password}) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        DatabaseReference ref = _database.ref("users/${user.uid}");
        await ref.set({"uid": user.uid, "email": email, "password": password});
      }
    });
  }

  void displaySuccess(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.1),
                spreadRadius: 10,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.check_circle_outline,
                size: 18,
                color: Colors.green,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Success",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
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

  void displayError(error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.1),
                spreadRadius: 10,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.error_outline,
                size: 18,
                color: Colors.red,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Error",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      error,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
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
        _confirmPassword == null ||
        _email!.isEmpty ||
        _password!.isEmpty ||
        _confirmPassword!.isEmpty) {
      return ('All fields are mandatory');
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
        if (_password != _confirmPassword) {
          return 'Passwords are different';
        } else {
          return null;
        }
      } else {
        return 'Password should contain at least 8 characters with at least one a-z, A-Z, 0-9 and special character';
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.decelerate);

    _animationController.forward();

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
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
                onPressed: () {
                  Navigator.pop(context);
                },
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
                        fontSize: _animation.value * 60,
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
                          style: kTextFormFieldStyle,
                          obscureText: _isPasswordHidden,
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
                      height: 20.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: kTextFormFieldOuterContainerStyle,
                      child: Center(
                        child: TextField(
                          style: kTextFormFieldStyle,
                          obscureText: _isConfirmPasswordHidden,
                          decoration: kTextFiledInputDecoration.copyWith(
                            hintText: 'confirm password',
                            prefixIcon: kGradientPasswordIcon,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordHidden =
                                      !_isConfirmPasswordHidden;
                                });
                              },
                              icon: _isConfirmPasswordHidden
                                  ? kGradientNotVisibleIcon
                                  : kGradientVisibleIcon,
                            ),
                          ),
                          onChanged: (value) {
                            _confirmPassword = value;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    BottomButton(
                      onPress: () async {
                        bool isValid = false;
                        String? error = _isInvalid();
                        error == null ? isValid = true : displayError(error);

                        if (isValid) {
                          try {
                            await register(
                                email: _email!, password: _password!);
                            displaySuccess('User Registered');
                          } catch (e) {
                            print('Registration Not Success......!');
                            print(e);
                          }
                        }
                      },
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
