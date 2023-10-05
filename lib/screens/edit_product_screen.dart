import 'package:firebase_crud_example/utils/bottom_button.dart';
import 'package:firebase_crud_example/utils/constants.dart';
import 'package:firebase_crud_example/utils/product_card.dart';
import 'package:firebase_crud_example/utils/rounded_product_text_field.dart';
import 'package:firebase_crud_example/utils/rounded_text_field.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String productName = 'Adidas Shoe';
    const String productId = 'AD8055';
    const String productQty = '9';
    const String productImage = 'images/shoe2.png';

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
                              'Edit Product',
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
                                    child: Image.asset(productImage),
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
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'Product Name',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const RoundedProductTextField(
                              hintText: 'Product Name',
                              labelText: productName,
                            ),
                            const Text(
                              'Product Name',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const RoundedProductTextField(
                              hintText: 'Product ID',
                              labelText: productId,
                            ),
                            const Text(
                              'Product Quantity',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const RoundedProductTextField(
                              hintText: 'Product Quantity',
                              labelText: productQty,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: BottomButton(
                                onPress: () {},
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
