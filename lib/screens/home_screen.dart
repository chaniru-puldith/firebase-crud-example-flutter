import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_example/utils/bottom_button.dart';
import 'package:firebase_crud_example/utils/constants.dart';
import 'package:firebase_crud_example/utils/product_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance;
  late User _loggedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        _loggedInUser = user;
        print(_loggedInUser.email.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String date = DateFormat.yMMMd().format(DateTime.now());
    final String name = _loggedInUser.email.toString().split('@')[0];

    Query dbRef = _database.ref().child('products');
    print(dbRef.get());
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
                          Text(
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
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                        child: StreamBuilder(
                          stream: dbRef.onValue,
                          builder:
                              (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                            List productList = [];
                            if (snapshot.hasData) {
                              Map<dynamic, dynamic> map =
                                  snapshot.data!.snapshot.value as dynamic;
                              map.forEach((key, value) {
                                productList.add(value);
                              });
                              print(productList[0]['id']);
                              print(productList[0]['name']);
                              print(productList[0]['qty']);
                              return ListView.builder(
                                  itemCount:
                                      snapshot.data!.snapshot.children.length,
                                  itemBuilder: (context, index) {
                                    return ProductCard(
                                      productName:
                                          '${productList[index]['name']}',
                                      productID: '${productList[index]['id']}',
                                      productQty: productList[index]['qty'],
                                      imagePath:
                                          '${productList[index]['image']}',
                                    );
                                  });
                            } else {
                              return const Center(child: Text('No Data'));
                            }
                          },
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
