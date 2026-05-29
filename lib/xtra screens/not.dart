import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/Common/Utils/colors.dart';
import 'package:flutter_application_1/xtra%20screens/notScreen.dart';
import 'package:iconsax/iconsax.dart';

class CusNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  InkWell(
      onTap: () {
        Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => CusNotificationScreen(),
  ),
);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(Iconsax.notification ,size: 28),
          SizedBox(),
        ],
      ),
    );
    
  }
}
