import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Order History", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: uId == null
          ? const Center(child: Text("Please Login First"))
          : StreamBuilder<QuerySnapshot>(
              // it take the current user order details only by filtering and take it based on the new date
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                  .orderBy('orderDate', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
  }

  if (snapshot.hasError) {
    print("Firestore Error: ${snapshot.error}"); 
    return Center(child: Text("Error: ${snapshot.error}"));
  }

  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    return const Center(child: Text("No Orders Placed Yet."));
  }

                final orders = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index].data() as Map<String, dynamic>;
                    final List items = order['items'] ?? [];
                    final Timestamp? date = order['orderDate'];

                    return Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order ID: ${orders[index].id}",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            Text("Date: ${date?.toDate().toString().substring(0, 16) ?? 'N/A'}"),
                            const Divider(),
                            // show the prodects in order
                            Column(
                              children: items.map((item) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("${item['productData']['name']} x ${item['quantity']}"),
                                  subtitle: Text("Size: ${item['selectedSize']} | Color: ${item['selectedColor']}"),
                                );
                              }).toList(),
                            ),
                            const Divider(),

                            Row(
  children: [
    Expanded(
      child: Text(
        "Address: ${order['deliveryAddress']}",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    ),
    Text(
      "Total: \$${order['totalPrice'].toStringAsFixed(2)}",
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
    ),
  ],
)
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}