import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/Core/Provider/cart_provider.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Screen/User%20Activity/Model/cart_model.dart';

import 'package:flutter_application_1/Core/Common/color_conversion.dart';

class CartItems extends ConsumerWidget {
  CartModel cart;

  CartItems({super.key, required this.cart});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CartProvider cp = ref.watch(cartService);
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        height: 120,
        width: size.width / 1.1,
        child: Stack(
          children: [
            Row(
              children: [
                const SizedBox(width: 20),
                //  corrected lines
                cart.productData['image'] != null &&
                        cart.productData['image'].startsWith('http')
                    ? Image.network(
                        cart.productData['image'],
                        height: 100,
                        width: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.broken_image,
                            size: 40,
                            color: Colors.grey,
                          );
                        },
                      )
                    : Image.asset(
                        cart.productData['image'] ?? "assets/Girl.jpg",
                        height: 100,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        cart.productData['name'] ?? 'No name',
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Color and Size Row
                      Row(
                        children: [
                          const Text("Color: "),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Color(
                              int.parse(cart.selectedColor),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text("Size: ${cart.selectedSize}"),
                        ],
                      ),
                      // Price Row
                      // corrected new lines
                      // Price and Quantity Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 1.  (Price)
                          Text(
                            "\$${(cart.productData['price'] * cart.quantity)}",
                            style: const TextStyle(
                              color: Colors.pink,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // 2. quantity buttons
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                // button -
                                GestureDetector(
                                  onTap: () {
                                    if (cart.quantity > 1) {
                                      // to reduce the quantity in your CartProvider (assuming you have a function like updateQuantity)
                                      cp.decreasQuantity(
                                        cart.productId,
                                        cart.selectedColor,
                                        cart.selectedSize,
                                      );
                                    } else {
                                      // If quantity is 1, removing the item from cart
                                      cp.removeFromCart(
                                        cart.productId,
                                        cart.selectedColor,
                                        cart.selectedSize,
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),

                                // Quantity Text
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    "${cart.quantity}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                // button(+)
                                GestureDetector(
                                  onTap: () {
                                    // to increse quantity in your CartProvider 
                                    cp.addQuantity(
                                      cart.productId,
                                      cart.selectedColor,
                                      cart.selectedSize,
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // remove Icon
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(53, 211, 206, 205),
                ),
                onPressed: () {
                  // delete when click the icon
                  cp.removeFromCart(
                    cart.productId,
                    cart.selectedColor,
                    cart.selectedSize,
                  );

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Removed")));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
