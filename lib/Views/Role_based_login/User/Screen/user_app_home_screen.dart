import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/Core/Common/Utils/cart_order_count.dart';
import 'package:flutter_application_1/Core/Provider/Models/category_model.dart';
import 'package:flutter_application_1/Core/Provider/Models/model.dart';
import 'package:flutter_application_1/Core/Provider/firestore_provider.dart';

import 'package:flutter_application_1/Core/Common/Utils/colors.dart';
import 'package:flutter_application_1/xtra screens/not.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Widgets/banner.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Widgets/curated_items.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Screen/Items_detail_screen/Screen/items_detail_screen.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Screen/categry_items.dart';

class UserAppHomeScreen extends ConsumerStatefulWidget {
  const UserAppHomeScreen({super.key});

  @override
  ConsumerState<UserAppHomeScreen> createState() => _UserAppHomeScreenState();
}

class _UserAppHomeScreenState extends ConsumerState<UserAppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final categoriesAsync = ref.watch(firestoreCategoriesProvider);
    final productsAsync = ref.watch(firestoreProductsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),

            //header part
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 020),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/Logo1.jpg",
                        height: 40,
                        fit: BoxFit.contain,
                      ),

                      SizedBox(width: 8),
                      Text(
                        "LankaFashion",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),

                  // CartOrderCount(), // return the crt items count

                  CusNotification()
                ],
              ),
            ),

            SizedBox(height: 20),
            MyBanner(),
            //Category
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shop By Category",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(
                    "See all",
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                ],
              ),
            ),

            //catgoris
            categoriesAsync.when(
              data: (categoriesList) {
                if (categoriesList.isEmpty) {
                  return const SizedBox(
                    height: 80,
                    child: Center(child: Text("No categories")),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      categoriesList.length,
                      (index) => InkWell(
                        onTap: () {
                          productsAsync.whenData((allProducts) {
                            final filterItems = allProducts
                                .where(
                                  (item) =>
                                      item.category.toLowerCase() ==
                                      categoriesList[index].name.toLowerCase(),
                                )
                                .toList();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CategoryItems(
                                  category: categoriesList[index].name,
                                  categoryItems: filterItems,
                                ),
                              ),
                            );
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: fbackgroundColor1,
                                backgroundImage: categoriesList[index].image.startsWith('http')
                                    ? NetworkImage(categoriesList[index].image) as ImageProvider
                                    : AssetImage(categoriesList[index].image),
                              ),
                            ),

                            SizedBox(height: 10),
                            Text(categoriesList[index].name),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              loading: () => const Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, stack) => Center(child: Text("Error: $e")),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Curated For You",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(
                    "See all",
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                ],
              ),
            ),

            productsAsync.when(
              data: (productsList) {
                if (productsList.isEmpty) {
                  return const SizedBox(
                    height: 150,
                    child: Center(child: Text("No products available")),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(productsList.length, (index) {
                      final eCommerceItems = productsList[index];
                      return Padding(
                        padding: index == 0
                            ? EdgeInsets.symmetric(horizontal: 20)
                            : EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ItemsDetailScreen(eCommerceApp: eCommerceItems),
                              ),
                            );
                          },
                          child: CuratedItems(
                            eCommerceItems: eCommerceItems,
                            size: size,
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
              loading: () => const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, stack) => Center(child: Text("Error: $e")),
            ),
          ],
        ),
      ),
    );
  }
}
