import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/Common/Utils/colors.dart';
import 'package:iconsax/iconsax.dart';

class CusNotificationScreen extends StatefulWidget {
  const CusNotificationScreen({super.key});

  @override
  State<CusNotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<CusNotificationScreen> {
  // Simulated premium notifications
  final List<Map<String, dynamic>> _notifications = [
    {
      "id": 1,
      "title": "Order Shipped! 🚀",
      "description": "Your order #LKA-9087 has been shipped and is on its way to you.",
      "time": "2 hours ago",
      "icon": Iconsax.box,
      "iconColor": Colors.blueAccent,
      "bgColor": const Color(0xFFE8F2FF),
      "isUnread": true,
    },
    {
      "id": 2,
      "title": "Exclusive Promo Code 🎉",
      "description": "Get 20% off your next purchase using code LANKAF20 at checkout.",
      "time": "5 hours ago",
      "icon": Iconsax.discount_shape,
      "iconColor": Colors.orangeAccent,
      "bgColor": const Color(0xFFFFF4E6),
      "isUnread": true,
    },
    {
      "id": 3,
      "title": "New Collection Alert! 🔥",
      "description": "The Summer Collection is now live. Explore the latest trend-setting apparel today.",
      "time": "1 day ago",
      "icon": Iconsax.flash,
      "iconColor": Colors.purpleAccent,
      "bgColor": const Color(0xFFF9E8FF),
      "isUnread": false,
    },
    {
      "id": 4,
      "title": "Security Update 🔒",
      "description": "Your account password was successfully updated. If this wasn't you, please contact support.",
      "time": "3 days ago",
      "icon": Iconsax.security_safe,
      "iconColor": Colors.teal,
      "bgColor": const Color(0xFFE6F7F5),
      "isUnread": false,
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var item in _notifications) {
        item["isUnread"] = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("All notifications marked as read"),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _deleteNotification(int id) {
    setState(() {
      _notifications.removeWhere((item) => item["id"] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (_notifications.isNotEmpty)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                "Mark all read",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade100,
            height: 1.0,
          ),
        ),
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState(size)
          : _buildNotificationList(),
    );
  }

  Widget _buildEmptyState(Size size) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: fbackgroundColor2,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.notification_status5,
              size: 56,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "No Notifications Yet",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "We'll notify you when something exciting happens! Keep an eye on this space for orders, discounts, and system updates.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 35),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Explore Trends",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        final item = _notifications[index];
        return Dismissible(
          key: Key(item["id"].toString()),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _deleteNotification(item["id"]);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Notification deleted"),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 1),
              ),
            );
          },
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.redAccent,
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
          child: Container(
            color: item["isUnread"] ? const Color(0xFFF9FAFC) : Colors.transparent,
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  leading: Stack(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: item["bgColor"],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item["icon"],
                          color: item["iconColor"],
                          size: 22,
                        ),
                      ),
                      if (item["isUnread"])
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item["title"],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: item["isUnread"] ? FontWeight.bold : FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Text(
                        item["time"],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      item["description"],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey.shade100,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
