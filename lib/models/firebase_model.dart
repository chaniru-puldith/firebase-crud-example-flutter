import 'package:firebase_crud_example/models/product_model.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseModel {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  Future<String> addProductData({required ProductModel product}) async {
    try {
      await _databaseReference.child('products').child(product.getId).set({
        'name': product.getName,
        'id': product.getId,
        'qty': product.getQty,
        'image': product.getImageUrl,
        'status': 'active',
      });
      return 'Success';
    } catch (e) {
      return 'Error while saving data';
    }
  }

  Future<String> deleteProductData({required productId}) async {
    try {
      await _databaseReference.child('products').child(productId).update({
        'status': 'disabled',
      });
      return 'Success';
    } catch (e) {
      return 'Error while saving data';
    }
  }

  Future<String> updateProductData(
      {required ProductModel product, required String oldId}) async {
    try {
      await _databaseReference.child('products').child(oldId).remove();
      await _databaseReference.child('products').child(product.getId).set({
        'name': product.getName,
        'id': product.getId,
        'qty': product.getQty,
        'image': product.getImageUrl,
        'status': 'active',
      });
      return 'Success';
    } catch (e) {
      return 'Error while saving data';
    }
  }
}
