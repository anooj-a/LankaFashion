import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter_application_1/Core/Provider/cart_provider.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Screen/User%20Activity/Add%20to%20Cart/Screen/Widgets/cart_items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/Core/Common/Utils/colors.dart';
// Import your PaymentModel if needed for type safety, assuming it's available via provider or static list for this UI demo
// import 'package:flutter_application_1/Core/Provider/Models/PaymentModel.dart'; 

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  String? selectedPaymentMethodId;
  double? selectedPaymentBalance;
  String? onPaymentMethdSelected;

  TextEditingController addressController = TextEditingController();
  
  // Dummy list for UI demonstration. In real app, fetch from Provider/Backend
  final List<Map<String, dynamic>> dummyPayments = [
    {"id": "1", "method": "Debit Card **** 4242", "balance": 500.0},
    {"id": "2", "method": "Cash on Delivery", "balance": 0.0},
  ];

  @override
  Widget build(BuildContext context) {
    final cp = ref.watch(cartService);
    final carts = cp.carts.reversed.toList();
    // TODO: implement build
    return Scaffold(
      backgroundColor: fbackgroundColor1,
      appBar: AppBar(
        backgroundColor: fbackgroundColor1,
        elevation: 0,
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: carts.isNotEmpty
                ? ListView.builder(
                    itemCount: carts.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: CartItems(cart: carts[index]),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "Your cat is empty!",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
          ),

          //for totalcart summary
          if (carts.isNotEmpty) _buildSummarySection(context, cp),
        ],
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context, CartProvider cp) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Delivery",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(width: 10),
              Expanded(child: DottedLine()),
              SizedBox(width: 10),
              Text(
                "\$${(cp.totalCart() + 4.99).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Total Order",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 10),
              Expanded(child: DottedLine()),
              SizedBox(width: 10),
              Text(
                "\$${(cp.totalCart()).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 40),
          MaterialButton(
            color: Colors.black,
            height: 70,
            minWidth: MediaQuery.of(context).size.width,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              _showOrderConfirmationDialog(context, cp);
            },
            child: Text(
              "Pay \$${((cp.totalCart() + 4.99).toStringAsFixed(2))}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderConfirmationDialog(BuildContext context, CartProvider cp) {
    //  local state variables for selections (used as dummy for this UI demo)
    String? tempSelectedPaymentId = selectedPaymentMethodId ?? "1"; // let's default to first method 

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Confirm your Order"),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListBody(
                      children: cp.carts.map((CartItem) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${CartItem.productData['name']} x ${CartItem.quantity}",
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Total Payable Price: \$${(cp.totalCart() + 4.99).toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Select Payment Method (Dummy)",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    const SizedBox(height: 10),

                    // --- Dummy Payment List UI ---
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: dummyPayments.map((payment) {
                          return RadioListTile<String>(
                            title: Text(payment['method']),
                            subtitle: Text("Balance: \$${payment['balance']} (Free Pass)"),
                            value: payment['id'],
                            groupValue: tempSelectedPaymentId,
                            onChanged: (value) {
                              setDialogState(() {
                                tempSelectedPaymentId = value;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      "Add Your Delivery Address",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        hintText: "Enter Your Address",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    //senjd the selected payment method id back to main state
                    setState(() {
                      selectedPaymentMethodId = tempSelectedPaymentId;
                    });

                    // If address is empty, assign a default address to prevent errors
                    if (addressController.text.trim().isEmpty) {
                      addressController.text = "Default University Delivery Address";
                    }

                    //without any condition, directly calls to save order! (for this UI demo, we are skipping payment validation and address validation for simplicity)
                    _saveOrder(cp); 
                    Navigator.pop(context); // closet the dialog
                  },
                  child: const Text("Confirm & Pay"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Main function to save order to Firebase
  void _saveOrder(CartProvider cp) async {
    final uId = FirebaseAuth.instance.currentUser?.uid;
    if (uId == null) return;

    try {
      // map the order details
      final orderData = {
        'userId': uId,
        'items': cp.carts.map((item) => item.toMap()).toList(),
        'totalPrice': cp.totalCart() + 4.99,
        'deliveryAddress': addressController.text.trim(),
        'paymentMethodId': selectedPaymentMethodId ?? "Dummy_Method",
        'orderDate': FieldValue.serverTimestamp(), // current time (align the order history)
      };

      // 1.  save the order in 'orders' collection
      await FirebaseFirestore.instance.collection('orders').add(orderData);

      // 2. Clear the cart in Firebase to prevent data inconsistency after login/logout
      await cp.clearCartFromFirebase();

      // 3.  clear the address field for next order (optional, but good for UX)
      addressController.clear();
      
      if (mounted) {
        // succes msg will arise in screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("🎉 Order Placed Successfully! Checked in Order History."),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Order Failed: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }
}