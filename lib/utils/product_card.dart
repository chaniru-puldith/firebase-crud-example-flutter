import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_crud_example/models/firebase_model.dart';

class ProductCard extends StatefulWidget {
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
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
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
                child: Image.network(widget.imagePath),
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
                      Text(widget.productName),
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
                      Text(widget.productID),
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
                      Text(widget.productQty.toString()),
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
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) => const Center(
                                        child: CircularProgressIndicator()));
                                var response = await FirebaseModel()
                                    .deleteProductData(
                                        productId: widget.productID);
                                response == "Success"
                                    ? displaySnackBar(
                                        message: 'Product deleted',
                                        type: SnackBarType.success,
                                      )
                                    : displaySnackBar(
                                        message:
                                            'Error while deleting the product',
                                        type: SnackBarType.error,
                                      );
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
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
