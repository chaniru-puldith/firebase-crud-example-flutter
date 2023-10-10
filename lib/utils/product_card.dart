import 'package:flutter/material.dart';
import 'constants.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productID;
  final int productQty;
  final String imagePath;

  const ProductCard({
    super.key,
    required this.productName,
    required this.productID,
    required this.productQty,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      width: MediaQuery.of(context).size.width * 0.85,
      height: 100,
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
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              flex: 1,
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.network(imagePath),
              ),
            ),
          ),
          Container(
            width: 2,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.all(Radius.circular(50))),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Name:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(productName),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      const Text(
                        'ID:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(productID),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      const Text(
                        'QTY:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(productQty.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {},
                  child: buildGradientIcon(const Icon(Icons.edit_outlined))),
              TextButton(
                  onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          title: const Text('Do you want to delete product?'),
                          content: const Text(
                              'If you don\'t want to delete this product please press \'No\'.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Yes'),
                              child: const Text(
                                'Yes',
                                style: TextStyle(color: Colors.orange),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'No'),
                              child: const Text(
                                'No',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                  child: buildGradientIcon(
                      const Icon(Icons.delete_outline_rounded))),
            ],
          ),
        ],
      ),
    );
  }
}
