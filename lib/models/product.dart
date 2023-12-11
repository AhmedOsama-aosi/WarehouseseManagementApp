class Product {
  //attributes = fields in table
  int? _productId;
  late String _productName;
  double? _productPrice;
  double? _productQuantity;
  double? _productMinimumQuantity;
  double? _productQuantityPerTon;
  late int _deleted;

//when it come form database
  Product(dynamic product) {
    _productId = product['ProductId'];
    _productName = product['ProductName'];
    _productPrice = product['Price'];
    _productQuantity = product['Quantity'];
    _productQuantityPerTon = product['QuantityPerTon'];
    _productMinimumQuantity = product['MinimumQuantity'];
    _deleted = product['Deleted'];
  }
  //when it come form map

  Product.fromMap(Map<dynamic, dynamic> product) {
    _productId = product['ProductId'];
    _productName = product['ProductName'];
    _productPrice = product['Price'];
    _productQuantity = product['Quantity'];
    _productQuantityPerTon = product['QuantityPerTon'];
    _productMinimumQuantity = product['MinimumQuantity'];
    _deleted = product['Deleted'];
  }

  Map<dynamic, dynamic> toMap() => {
        'ProductId': _productId,
        'ProductName': _productName,
        'Price': _productPrice,
        'Quantity': _productQuantity,
        'QuantityPerTon': _productQuantityPerTon,
        'MinimumQuantity': _productMinimumQuantity,
        'Deleted': _deleted
      };

  int get id => _productId!;
  String get productName => _productName;
  double get productPrice => _productPrice!;
  double get productQuantity => _productQuantity!;
  double get productMinimumQuantity => _productMinimumQuantity!;
  double get productQuantityPerTon => _productQuantityPerTon!;
  int get deleted => _deleted;
}
