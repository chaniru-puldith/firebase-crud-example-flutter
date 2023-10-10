class ProductModel {
  String _name;
  String _id;
  int _qty;
  String _imageUrl;

  ProductModel({
    required id,
    required name,
    required qty,
    required imageUrl,
  })  : _id = id,
        _name = name,
        _qty = qty,
        _imageUrl = imageUrl;

  String get getName => _name;

  String get getId => _id;

  int get getQty => _qty;

  String get getImageUrl => _imageUrl;

  set setName(String name) {
    _name = name;
  }

  set setID(String id) {
    _id = id;
  }

  set setQty(int qty) {
    _qty = qty;
  }

  set setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
  }
}
