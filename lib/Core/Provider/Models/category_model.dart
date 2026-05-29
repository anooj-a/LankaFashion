import 'package:flutter_application_1/Core/Common/Utils/drive_helper.dart';

class Category {
  String name, image;

  Category({required this.name, required this.image});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'] ?? '',
      image: convertToDirectDriveLink(map['image'] ?? ''),
    );
  }
}

List<Category> category = [
  Category(
    name: "Women",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/v1779793559/women_ktskma.png",
  ),
  Category(
    name: "Men",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779793556/men_dcpmy0.png",
  ),
  Category(
    name: "Teens",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779793559/teen_ebys6n.png",
  ),
  Category(
    name: "Kids",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779793559/kids_vjljsh.png",
  ),
  Category(
    name: "Baby",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779793557/baby_qkosah.png",
  ),
];

List<String> filterCategory = [
  "Filter",
  "Ratings",
  "Size",
  "Color",
  "Price",
  "Brand",
];
