import 'package:firebase_crud_example/screens/add_product_screen.dart';
import 'package:firebase_crud_example/screens/edit_product_screen.dart';
import 'package:firebase_crud_example/screens/home_screen.dart';
import 'package:firebase_crud_example/screens/login_screen.dart';
import 'package:firebase_crud_example/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditProductScreen(),
    );
  }
}
