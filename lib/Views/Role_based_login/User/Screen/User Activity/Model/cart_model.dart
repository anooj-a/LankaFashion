class CartModel {
  String productId;
  Map<String, dynamic> productData;
  int quantity;
  String selectedColor, selectedSize;

  CartModel({
    required this.productId,
    required this.productData,
    required this.quantity,
    required this.selectedColor,
    required this.selectedSize,
  });

  //  method to convert to Map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productData': productData,
      'quantity': quantity,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
    };
  }

  // method for converting Firestore data to Object
  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productId: map['productId'] ?? '',
      productData: Map<String, dynamic>.from(map['productData'] ?? {}),
      quantity: map['quantity'] ?? 1,
      selectedColor: map['selectedColor'] ?? '',
      selectedSize: map['selectedSize'] ?? '',
    );
  }
}