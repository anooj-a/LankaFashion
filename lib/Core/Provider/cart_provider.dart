import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Screen/User%20Activity/Model/cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartService = ChangeNotifierProvider<CartProvider>((ref) => CartProvider());

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];
  List<CartModel> get carts => _carts;
  
  final FirebaseFirestore _db = FirebaseFirestore.instance;

//hel to fetc th data from frebase
  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  CartProvider() {
    loadCartItems();
  }

  // to oad cart etails from Firestore 
  Future<void> loadCartItems() async {
    if (_uid == null) return;
    try {
      final snapshot = await _db.collection('users').doc(_uid).collection('cart').get();
      _carts = snapshot.docs.map((doc) => CartModel.fromMap(doc.data())).toList();
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading cart: $e");
    }
  }

  // to create unique ID for each cart item (same product can be in different color/size)
  String _getCartItemId(String productId, String color, String size) {
    return "${productId}_${color}_$size";
  }

  void reset() {
    _carts = [];
    notifyListeners();
  }

  // to add new item to cart or increase quantity if same item with same color and size already exists in cart
  Future<void> addCart(String productId, Map<String, dynamic> productData, String selectedColor, String selectedSize) async {
    int index = _carts.indexWhere((el) => el.productId == productId && el.selectedColor == selectedColor && el.selectedSize == selectedSize);
    String itemId = _getCartItemId(productId, selectedColor, selectedSize);

    if (index != -1) {
      _carts[index].quantity += 1;
      if (_uid != null) {
        await _db.collection('users').doc(_uid).collection('cart').doc(itemId).update({'quantity': _carts[index].quantity});
      }
    } else {
      final newItem = CartModel(
        productId: productId,
        productData: productData,
        quantity: 1,
        selectedColor: selectedColor,
        selectedSize: selectedSize,
      );
      _carts.add(newItem);
      if (_uid != null) {
        await _db.collection('users').doc(_uid).collection('cart').doc(itemId).set(newItem.toMap());
      }
    }
    notifyListeners();
  }

  // to increase quantity of a cart item in cart screen when + button is clicked
  Future<void> addQuantity(String productId, String color, String size) async {
    int index = _carts.indexWhere((el) => el.productId == productId && el.selectedColor == color && el.selectedSize == size);
    if (index != -1) {
      _carts[index].quantity += 1;
      notifyListeners();
      if (_uid != null) {
        String itemId = _getCartItemId(productId, color, size);
        await _db.collection('users').doc(_uid).collection('cart').doc(itemId).update({'quantity': _carts[index].quantity});
      }
    }
  }

  // to decrease quantity of a cart item in cart screen
  Future<void> decreasQuantity(String productId, String color, String size) async {
    int index = _carts.indexWhere((el) => el.productId == productId && el.selectedColor == color && el.selectedSize == size);
    if (index != -1) {
      String itemId = _getCartItemId(productId, color, size);
      _carts[index].quantity -= 1;
      
      if (_carts[index].quantity <= 0) {
        _carts.removeAt(index);
        if (_uid != null) {
          await _db.collection('users').doc(_uid).collection('cart').doc(itemId).delete();
        }
      } else {
        if (_uid != null) {
          await _db.collection('users').doc(_uid).collection('cart').doc(itemId).update({'quantity': _carts[index].quantity});
        }
      }
      notifyListeners();
    }
  }

  // Delete Icon to remove from cart screen
  Future<void> removeFromCart(String productId, String color, String size) async {
    _carts.removeWhere((item) => item.productId == productId && item.selectedColor == color && item.selectedSize == size);
    notifyListeners();
    if (_uid != null) {
      String itemId = _getCartItemId(productId, color, size);
      await _db.collection('users').doc(_uid).collection('cart').doc(itemId).delete();
    }
  }

  // to clear the entire cart after placing an order
  Future<void> clearCartFromFirebase() async {
    if (_uid == null) return;
    final cartRef = _db.collection('users').doc(_uid).collection('cart');
    final snapshots = await cartRef.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    reset();
  }

  double totalCart() {
    double total = 0;
    for (var item in _carts) {
      final price = (item.productData['price'] ?? 0) as num;
      final discount = (item.productData['discountPercentage'] ?? 0) as num;
      final finalprice = price * (1 - discount / 100);
      total += item.quantity * finalprice;
    }
    return total;
  }
}