import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Core/Provider/Models/category_model.dart';
import 'package:flutter_application_1/Core/Provider/Models/model.dart';

Future<void> seedDatabase() async {
  final firestore = FirebaseFirestore.instance;

  try {
    // 1. Seed Categories
    final categoryQuery = await firestore.collection('categories').get();
    if (categoryQuery.docs.isEmpty) {
      print("Seeding categories to Firestore...");
      for (var cat in category) {
        await firestore.collection('categories').add({
          'name': cat.name,
          'image': cat.image,
        });
      }
      print("Categories seeded successfully!");
    } else {
      print("Categories already exist in Firestore. Skipping seeding.");
    }

    // 2. Seed Products
    final productQuery = await firestore.collection('products').get();
    if (productQuery.docs.isEmpty) {
      print("Seeding products to Firestore...");
      for (var prod in fashionEcommerceApp) {
        await firestore.collection('products').add({
          'name': prod.name,
          'image': prod.image,
          'price': prod.price,
          'rating': prod.rating,
          'review': prod.review,
          'description': prod.description,
          'category': prod.category,
          'isCheck': prod.isCheck,
          'size': prod.size,
          'fcolor': prod.fcolor.map((color) => color.value).toList(),
        });
      }
      print("Products seeded successfully!");
    } else {
      print("Products already exist in Firestore. Skipping seeding.");
    }
  } catch (e) {
    print("Error seeding database: $e");
  }
}
