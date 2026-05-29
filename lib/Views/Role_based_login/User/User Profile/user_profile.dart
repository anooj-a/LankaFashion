import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/Provider/cart_provider.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Screen/user_app_main_screen.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/User%20Profile/OrderHistoryScreen.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/User%20Profile/Payment/Payment_screen.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/login_screen.dart';
import 'package:flutter_application_1/services/auth_serivices.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'edit_profile_screen.dart';        //edit screen

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("My Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const UserAppMainScreen()),
            );
          },
        ),
      ),
      body: userId == null
          ? const Center(child: Text("No User ID"))
          : StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("users").doc(userId).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text("No Details"));
                }

                final user = snapshot.data!;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      
                      // 📸 PROFILE IMAGE CLICKABLE LOGIC
                      GestureDetector(
                        onTap: () {
                          // when press the image, it leads edit screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(userDocument: user),
                            ),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            const CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage("assets/download.png"),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit, color: Colors.white, size: 16),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 15),
                      Text(
                        user['name'] ?? 'No Name',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user['email'] ?? 'No Email',
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      
                      const SizedBox(height: 30),
                      const Divider(),

                      // Actions List
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PaymentScreen()),
                          );
                        },
                        leading: const Icon(Icons.payments, size: 28),
                        title: const Text("Payment Method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                      
ListTile(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrderHistoryScreen()),
    );
  },
  leading: const Icon(Icons.history_edu, size: 28),
  title: const Text("Order History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
),
                      const ListTile(
                        leading: Icon(Icons.info, size: 28),
                        title: Text("About Us", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      ),
                      ListTile(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          ref.invalidate(cartService);
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                              (route) => false,
                            );
                          }
                        },
                        leading: const Icon(Icons.exit_to_app, size: 28, color: Colors.red),
                        title: const Text("Log Out", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}