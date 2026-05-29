import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/Provider/cart_provider.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Screen/User%20Activity/Add%20to%20Cart/Screen/cart_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class CartOrderCount extends ConsumerWidget {
  const CartOrderCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CartProvider cp = ref.watch(cartService);
    // TODO: implement build
     return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartScreen()),
        );
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Iconsax.shopping_bag, size: 28),
          ),
          if (cp.carts.isNotEmpty) // show when cart i empty
            Positioned(
              right: 2,
              top: 2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: Center(
                  child: Text(
                    "${cp.carts.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ), 
        ],
      )
      );
    
  }
}
    
 