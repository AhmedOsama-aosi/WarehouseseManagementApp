class OperationDetials {
  late int _productId;
  late int _operationId;
  late int _clintId;
  late double _price;
  late double _quantity;
  late double _totalPrice;

  OperationDetials(dynamic product) {
    _productId = product['ProductId '];
    _operationId = product['OperationId '];
    _clintId = product['ClintId'];
    _price = product['Price'];
    _quantity = product['Quantity '];
    _totalPrice = product['TotalPrice '];
  }

  OperationDetials.fromJson(Map<String, dynamic> product) {
    _productId = product['ProductId '];
    _operationId = product['OperationId '];
    _clintId = product['ClintId'];
    _price = product['Price'];
    _quantity = product['Quantity '];
    _totalPrice = product['TotalPrice '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductId '] = _productId;
    data['OperationId '] = _operationId;
    data['ClintId'] = _clintId;
    data['Price'] = _price;
    data['Quantity '] = _quantity;
    data['TotalPrice '] = _totalPrice;
    return data;
  }

  // int get productId => _productId;
  // set productId(int productId) => _productId = productId;
  // int get operationId => _operationId;
  // set operationId(int operationId) => _operationId = operationId;
  // int get clintId => _clintId;
  // set clintId(int clintId) => _clintId = clintId;
  // double get price => _price;
  // set price(double price) => _price = price;
  // double get quantity => _quantity;
  // set quantity(double quantity) => _quantity = quantity;
  // double get totalPrice => _totalPrice;
  // set totalPrice(double totalPrice) => _totalPrice = totalPrice;
}
