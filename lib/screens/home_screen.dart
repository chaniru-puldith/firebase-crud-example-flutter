import 'package:firebase_crud_example/utils/bottom_button.dart';
import 'package:firebase_crud_example/utils/constants.dart';
import 'package:firebase_crud_example/utils/product_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String date = DateFormat.yMMMd().format(DateTime.now());
    const String name = 'Chaniru';
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: kGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          const Text(
                            'Hi, $name!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            date,
                            style: TextStyle(
                              color: Colors.blue.shade100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: Text(
                              'Browse Products',
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
              flex: 7,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Products',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade800,
                            ),
                          ),
                          BottomButton(
                            onPress: () {},
                            buttonTitle: 'Add Product',
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          children: const [
                            ProductCard(
                              productName: 'Adidas Shoe',
                              productID: 'AD8055',
                              productQty: 9,
                              imagePath: 'images/shoe2.png',
                            ),
                            ProductCard(
                              productName: 'Puma Shoe',
                              productID: 'PU7805',
                              productQty: 11,
                              imagePath: 'images/shoe3.png',
                            ),
                            ProductCard(
                              productName: 'Nike Shoe',
                              productID: 'NI2057',
                              productQty: 10,
                              imagePath: 'images/shoe4.png',
                            ),
                            ProductCard(
                              productName: 'Adidas Shoe',
                              productID: 'AD8055',
                              productQty: 9,
                              imagePath: 'images/shoe2.png',
                            ),
                            ProductCard(
                              productName: 'Puma Shoe',
                              productID: 'PU7805',
                              productQty: 11,
                              imagePath: 'images/shoe3.png',
                            ),
                            ProductCard(
                              productName: 'Nike Shoe',
                              productID: 'NI2057',
                              productQty: 10,
                              imagePath: 'images/shoe4.png',
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
