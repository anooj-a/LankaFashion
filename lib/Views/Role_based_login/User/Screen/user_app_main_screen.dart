import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_application_1/Core/Common/Utils/cart_order_count.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Screen/User%20Activity/Add%20to%20Cart/Screen/cart_screen.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Screen/user_app_home_screen.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/User%20Profile/user_profile.dart';
import 'package:flutter_application_1/xtra%20screens/search.dart';
import 'package:flutter_application_1/xtra%20screens/not.dart';
import 'package:iconsax/iconsax.dart';

class UserAppMainScreen extends StatefulWidget {
  const UserAppMainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserAppMainScreenState();
}

class _UserAppMainScreenState extends State<UserAppMainScreen> {
  int selectedIndex = 0;
  List pages = [UserAppHomeScreen(), Search(), CartScreen(), UserProfile()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
  setState(() {
    selectedIndex = value; // should change index inside setState
  });
},
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Iconsax.search_normal),
            label: "Search",
          ),
          BottomNavigationBarItem(
    icon: CartOrderCount(), // 
    label: "Cart",
  ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),

      body: pages[selectedIndex],
    );
  }
}
