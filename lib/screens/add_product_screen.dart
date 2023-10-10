import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_crud_example/models/firebase_model.dart';
import 'package:firebase_crud_example/models/product_model.dart';
import 'package:firebase_crud_example/utils/bottom_button.dart';
import 'package:firebase_crud_example/utils/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _database = FirebaseDatabase.instance;
  final _storage = FirebaseStorage.instance;
  String? _path;
  String? _fileName;
  String? _name;
  String? _id;
  String? _qty;
  Widget _imageWidget = Image.asset('images/shoe1.png');

  Future<String?> uploadFile(
      {required String filepath, required String filename}) async {
    print('$filename $filepath');
    File file = File(filepath);

    try {
      await _storage.ref("products/$filename").putFile(file);
      var url = await _storage.ref("products/$filename").getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return null;
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: kGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Add New Product',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Enter Details',
                        style: TextStyle(
                          color: Colors.blueGrey.shade800,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: _imageWidget,
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
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
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: TextButton(
                                    child: const Text(
                                      'Select Image',
                                      style:
                                          TextStyle(color: Colors.indigoAccent),
                                    ),
                                    onPressed: () async {
                                      final results =
                                          await FilePicker.platform.pickFiles(
                                        allowMultiple: false,
                                        type: FileType.custom,
                                        allowedExtensions: ['png'],
                                      );

                                      if (results == null) {
                                        displaySnackBar(
                                            message: "No File Selected",
                                            type: SnackBarType.error);
                                        return;
                                      } else {
                                        _path = results.files.single.path!;
                                        _fileName = results.files.single.name;

                                        setState(() {
                                          _imageWidget =
                                              Image.file(File(_path!));
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: kTextFormFieldOuterContainerStyle,
                              child: Center(
                                child: TextField(
                                  style: kTextFormFieldStyle,
                                  decoration:
                                      kTextFiledInputDecoration.copyWith(
                                    hintText: 'Product Name',
                                  ),
                                  onChanged: (value) {
                                    _name = value;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: kTextFormFieldOuterContainerStyle,
                              child: Center(
                                child: TextField(
                                  style: kTextFormFieldStyle,
                                  decoration:
                                      kTextFiledInputDecoration.copyWith(
                                    hintText: 'Product ID',
                                  ),
                                  onChanged: (value) {
                                    _id = value;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: kTextFormFieldOuterContainerStyle,
                              child: Center(
                                child: TextField(
                                  style: kTextFormFieldStyle,
                                  keyboardType: TextInputType.number,
                                  decoration:
                                      kTextFiledInputDecoration.copyWith(
                                    hintText: 'Product Quantity',
                                  ),
                                  onChanged: (value) {
                                    _qty = value;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: BottomButton(
                                onPress: () async {
                                  if (_name == null ||
                                      _qty == null ||
                                      _id == null ||
                                      _qty == null) {
                                    displaySnackBar(
                                        message:
                                            "Product Name, Product ID, Product Quantity, Product Image can\'t be empty",
                                        type: SnackBarType.error);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => const Center(
                                            child:
                                                CircularProgressIndicator()));

                                    String? response = await uploadFile(
                                        filepath: _path!, filename: '$_id.png');

                                    if (response == null) {
                                      Navigator.of(context).pop();

                                      displaySnackBar(
                                        message:
                                            'Error while uploading the product image',
                                        type: SnackBarType.error,
                                      );
                                    } else {
                                      int _qtyNumber = int.parse(_qty!);
                                      ProductModel product = ProductModel(
                                          id: _id,
                                          name: _name,
                                          qty: _qtyNumber,
                                          imageUrl: response);
                                      FirebaseModel firebaseModel =
                                          FirebaseModel();
                                      var firebaseResponse = await firebaseModel
                                          .addProductData(product: product);
                                      firebaseResponse == "Success"
                                          ? displaySnackBar(
                                              message: 'New product added',
                                              type: SnackBarType.success,
                                            )
                                          : displaySnackBar(
                                              message:
                                                  'Error while adding the product',
                                              type: SnackBarType.error,
                                            );
                                      Navigator.of(context).pop();
                                    }
                                    Navigator.of(context).pop();
                                  }
                                },
                                buttonTitle: 'Add Product ➜',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
