import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/Provider/Models/category_model.dart';
import 'package:flutter_application_1/Core/Provider/Models/model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreCategoriesProvider = StreamProvider<List<Category>>((ref) {
  return FirebaseFirestore.instance.collection('categories').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Category.fromMap(doc.data())).toList();
  });
});

final firestoreProductsProvider = StreamProvider<List<AppModel>>((ref) {
  return FirebaseFirestore.instance.collection('products').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => AppModel.fromMap(doc.data())).toList();
  });
});
