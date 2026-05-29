// item screen copilot
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import 'package:flutter_application_1/Core/Common/Utils/cart_order_count.dart';
import 'package:flutter_application_1/Core/Provider/Models/model.dart';
import 'package:flutter_application_1/Core/Common/Utils/colors.dart';
import 'package:flutter_application_1/Core/Provider/cart_provider.dart';

class ItemsDetailScreen extends ConsumerStatefulWidget {
  final AppModel eCommerceApp;

  const ItemsDetailScreen({super.key, required this.eCommerceApp});

  @override
  ConsumerState<ItemsDetailScreen> createState() => _ItemsDetailScreenState();
}

class _ItemsDetailScreenState extends ConsumerState<ItemsDetailScreen> {
  int currentIndex = 0;
  int selectedColorIndex = 0;
  int selectedSizeIndex = 0;

  // for manage product count
  int purchaseQuantity = 1;

  // text controller for direct buying
  final TextEditingController detailAddressController = TextEditingController();
  String selectedDirectPaymentId = "1";

  final List<Map<String, dynamic>> directDummyPayments = [
    {"id": "1", "method": "Debit Card **** 4242", "balance": 500.0},
    {"id": "2", "method": "Cash on Delivery", "balance": 0.0},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartProvider = ref.watch(cartService);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: fbackgroundColor2,
        title: const Text("Detail Product"),
        actions: [CartOrderCount(), const SizedBox(width: 20)],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product image carousel
            SizedBox(
              height:
                  size.height *
                  0.40, // hight is changed to avoid overflow
              width: size.width,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  // picture only paced removing unwnted col
                  return Hero(
                    tag: widget.eCommerceApp.image,
                    child: widget.eCommerceApp.image.startsWith('http')
                        ? Image.network(
                            widget.eCommerceApp.image,
                            height: size.height * 0.4,
                            width: size.width * 0.85,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            widget.eCommerceApp.image,
                            height: size.height * 0.4,
                            width: size.width * 0.85,
                            fit: BoxFit.cover,
                          ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            // page indicator dots moved outside of PageView for better layout and visibility
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 4),
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: index == currentIndex
                        ? Colors.blueAccent
                        : Colors.grey,
                  ),
                ),
              ),
            ),

            // Product details
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand + rating
                  Row(
                    children: [
                      const Text(
                        "H&M",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black26,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.star, color: Colors.amber, size: 17),
                      Text(widget.eCommerceApp.rating.toString()),
                      Text(
                        "(${widget.eCommerceApp.review})",
                        style: const TextStyle(color: Colors.black26),
                      ),
                      const Spacer(),
                      const Icon(Icons.favorite_border),
                    ],
                  ),

                  // Product name
                  Text(
                    widget.eCommerceApp.name,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  // Price
                  Row(
                    children: [
                      Text(
                        "\$${widget.eCommerceApp.price}.00",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.pink,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(width: 5),
                      if (widget.eCommerceApp.isCheck == true)
                        Text(
                          "\$${widget.eCommerceApp.price + 255}.00",
                          style: const TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.black26,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Description
                  Text(
                    "This is a great ${widget.eCommerceApp.name} for your wardrobe.",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black38,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Color and Size selectors
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Color",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: widget.eCommerceApp.fcolor
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                      final int index = entry.key;
                                      final Color color = entry.value;
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          right: 10,
                                        ),
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: color,
                                          child: InkWell(
                                            onTap: () => setState(
                                              () => selectedColorIndex = index,
                                            ),
                                            child: Icon(
                                              Icons.check,
                                              color: selectedColorIndex == index
                                                  ? Colors.white
                                                  : Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Size",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: widget.eCommerceApp.size
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                      final int index = entry.key;
                                      final String size = entry.value;
                                      return GestureDetector(
                                        onTap: () => setState(
                                          () => selectedSizeIndex = index,
                                        ),
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            right: 10,
                                            top: 10,
                                          ),
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: selectedSizeIndex == index
                                                ? Colors.black
                                                : Colors.white,
                                            border: Border.all(
                                              color: selectedSizeIndex == index
                                                  ? Colors.black
                                                  : Colors.black12,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              size,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    selectedSizeIndex == index
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // widget to change product quantity
                  const Text(
                    "Quantity",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (purchaseQuantity > 1) {
                            setState(() {
                              purchaseQuantity--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove_circle_outline, size: 30),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        purchaseQuantity.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 15),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            purchaseQuantity++;
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline, size: 30),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ), // Bottom Padding for not hiding floating button
                ],
              ),
            ),
          ],
        ),
      ),

      // Floating buttons
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {},
        label: SizedBox(
          width: size.width * 0.9,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // CartProvider - while calling addcart
                    cartProvider.addCart(
                      widget.eCommerceApp.name,
                      {
                        "name": widget.eCommerceApp.name,
                        "image": widget.eCommerceApp.image,
                        "price": widget.eCommerceApp.price,
                      },
                      widget.eCommerceApp.fcolor[selectedColorIndex].value
                          .toString(),
                      widget.eCommerceApp.size[selectedSizeIndex],
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${widget.eCommerceApp.name} added to cart",
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Iconsax.shopping_bag, color: Colors.black),
                        SizedBox(width: 5),
                        Text(
                          "ADD TO CART",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _showOrderConfirmationDialog();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        "BUY NOW",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _showOrderConfirmationDialog() {
    double totalProductPrice =
        (widget.eCommerceApp.price * purchaseQuantity) + 4.99;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: const Text("Confirm your Order"),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.eCommerceApp.name} x $purchaseQuantity",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Total Payable Price: \$${totalProductPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Select Payment Method",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: directDummyPayments.map((payment) {
                          return RadioListTile<String>(
                            title: Text(payment['method']),
                            subtitle: Text(
                              payment['id'] == "1"
                                  ? "Balance: \$${payment['balance']}"
                                  : "Pay upon delivery",
                            ),
                            value: payment['id'],
                            groupValue: selectedDirectPaymentId,
                            onChanged: (value) {
                              setDialogState(() {
                                selectedDirectPaymentId = value!;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      "Add Your Delivery Address",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: detailAddressController,
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
                    Navigator.pop(dialogContext);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final uId = FirebaseAuth.instance.currentUser?.uid;
                    if (uId == null) return;

                    if (detailAddressController.text.trim().isEmpty) {
                      detailAddressController.text =
                          "Default University Delivery Address";
                    }

                    try {
                      Navigator.pop(dialogContext);

                      String finalMethod = directDummyPayments.firstWhere(
                        (p) => p['id'] == selectedDirectPaymentId,
                      )['method'];

                      final directOrderData = {
                        'userId': uId,
                        'items': [
                          {
                            'productId': widget.eCommerceApp.name,
                            'productData': {
                              'name': widget.eCommerceApp.name,
                              'image': widget.eCommerceApp.image,
                              'price': widget.eCommerceApp.price,
                            },
                            'quantity': purchaseQuantity,
                            'selectedColor': widget
                                .eCommerceApp
                                .fcolor[selectedColorIndex]
                                .value
                                .toString(),
                            'selectedSize':
                                widget.eCommerceApp.size[selectedSizeIndex],
                          },
                        ],
                        'totalPrice': totalProductPrice,
                        'deliveryAddress': detailAddressController.text.trim(),
                        'paymentMethodId': finalMethod,
                        'orderDate': FieldValue.serverTimestamp(),
                      };

                      await FirebaseFirestore.instance
                          .collection('orders')
                          .add(directOrderData);
                      detailAddressController.clear();

                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "🎉 ${widget.eCommerceApp.name} Order Placed Successfully!",
                            ),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Order Failed: $e"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Confirm & Pay"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
