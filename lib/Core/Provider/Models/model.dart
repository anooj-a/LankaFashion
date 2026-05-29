import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/Common/Utils/drive_helper.dart';

class AppModel {
  String name, image, description, category;
  double rating;
  int review, price;
  List<Color> fcolor;
  List<String> size;
  bool isCheck;

  AppModel({
    required this.name,
    required this.image,
    required this.rating,
    required this.price,
    required this.review,
    required this.fcolor,
    required this.size,
    required this.description,
    required this.isCheck,
    required this.category,
  });

  factory AppModel.fromMap(Map<String, dynamic> map) {
    return AppModel(
      name: map['name'] ?? '',
      image: convertToDirectDriveLink(map['image'] ?? ''),
      rating: (map['rating'] ?? 0.0).toDouble(),
      price: map['price'] ?? 0,
      review: map['review'] ?? 0,
      fcolor:
          (map['fcolor'] as List<dynamic>?)
              ?.map((colorValue) => Color(colorValue as int))
              .toList() ??
          [],
      size: List<String>.from(map['size'] ?? []),
      description: map['description'] ?? '',
      isCheck: map['isCheck'] ?? false,
      category: map['category'] ?? '',
    );
  }
}

List<AppModel> fashionEcommerceApp = [
  // 1
  AppModel(
    name: "Top Heel",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779891081/1_rwc0cd.jpg",
    rating: 5.0,
    price: 295,
    review: 1364,
    fcolor: [Colors.black, Colors.blue, Colors.yellow],
    size: ["XS", "S", "M"],
    description: "",
    isCheck: true,
    category: "Women",
  ),
  AppModel(
    name: "White Top",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779891067/6_l2twin.png",
    rating: 5.0,
    price: 295,
    review: 1364,
    fcolor: [Colors.black, Colors.blue, Colors.yellow],
    size: ["XS", "S", "M"],
    description: "",
    isCheck: true,
    category: "Women",
  ),

  AppModel(
    name: "B",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779891067/7_j8b90z.png",
    rating: 4.0,
    price: 300,
    review: 1364,
    fcolor: [Colors.black, Colors.blue, Colors.yellow],
    size: ["XS", "S", "M"],
    description: "",
    isCheck: true,
    category: "Women",
  ),

  AppModel(
    name: "Blue",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779891067/8_svlxqv.png",
    rating: 3.0,
    price: 300,
    review: 1364,
    fcolor: [Colors.black, Colors.blue, Colors.yellow],
    size: ["XS", "S", "M"],
    description: "",
    isCheck: true,
    category: "Women",
  ),

  // 2
  AppModel(
    name: "bluek",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779898294/1_l3gkj8.png",
    rating: 4.9,
    price: 295,
    review: 136,
    fcolor: [Colors.black, Colors.blue, Color.fromARGB(255, 82, 213, 16)],
    size: ["XS", "S", "M"],
    description: "",
    isCheck: true,
    category: "Men",
  ),

  AppModel(
    name: "blue-shirt",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779898293/2_adacwt.jpg",
    rating: 4.9,
    price: 25,
    review: 136,
    fcolor: [Colors.black, Colors.blue, Color.fromARGB(255, 82, 213, 16)],
    size: ["XS", "S", "M"],
    description: "",
    isCheck: true,
    category: "Men",
  ),

  AppModel(
    name: "Red d",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779898293/3_ccmt4t.png",
    rating: 4.9,
    price: 295,
    review: 136,
    fcolor: [Colors.black, Colors.blue, Color.fromARGB(255, 82, 213, 16)],
    size: ["XS", "S", "M"],
    description: "",
    isCheck: true,
    category: "Men",
  ),

  // 1
  AppModel(
    name: "Kiddy",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779898702/5_mns4mh.jpg",
    rating: 4.9,
    price: 295,
    review: 136,
    fcolor: [Colors.black, Colors.blue, Color.fromARGB(255, 65, 79, 92)],
    size: ["XS", "S", "M"],
    description: "",
    isCheck: true,
    category: "Teens",
  ),

  AppModel(
    name: "Ki",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779898633/2_fzpwkn.png",
    rating: 4.9,
    price: 295,
    review: 136,
    fcolor: [Colors.black, Colors.blue, Color.fromARGB(255, 65, 79, 92)],
    size: ["XS", "S", "M", "L"],
    description: "",
    isCheck: true,
    category: "Teens",
  ),

  AppModel(
    name: "Kiddy Chik",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779898633/1_tqfhpn.png",
    rating: 4.9,
    price: 295,
    review: 136,
    fcolor: [Colors.black, Colors.blue, Color.fromARGB(255, 65, 79, 92)],
    size: ["XS", "S", "M", "L"],
    description: "",
    isCheck: true,
    category: "Teens",
  ),

  AppModel(
    name: "Kiddy",
    image:
        "https://drive.google.com/file/d/1ScyTafOTFKSjg4ZHmQmbTsr5q4zmZ0GS/view?usp=drive_link",
    rating: 4.9,
    price: 295,
    review: 136,
    fcolor: [Colors.black, Colors.blue, Color.fromARGB(255, 65, 79, 92)],
    size: ["XS", "S", "M", "L"],
    description: "",
    isCheck: true,
    category: "Teens",
  ),

  AppModel(
    name: "Toddy  R",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779860516/1_d5obkg.png",
    rating: 2.9,
    price: 29115,
    review: 116,
    fcolor: [Colors.black, Colors.blue, const Color.fromARGB(255, 65, 79, 92)],
    size: ["XS", "S", "M"],
    description: "",
    isCheck: true,
    category: "Kids",
  ),

  AppModel(
    name: "Coat",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779860516/2_ovvvsu.png",
    rating: 4.9,
    price: 295,
    review: 136,
    fcolor: [Colors.black, Colors.blue, const Color.fromARGB(255, 65, 79, 92)],
    size: ["XS", "S", "M"],
    description: "",
    isCheck: true,
    category: "Kids",
  ),

  AppModel(
    name: "Todlers",
    image:
        "https://res.cloudinary.com/dlfquz8jo/image/upload/q_auto/f_auto/v1779860518/3_tlph1p.png",
    rating: 4.9,
    price: 295,
    review: 136,
    fcolor: [Colors.black, Colors.blue, const Color.fromARGB(255, 65, 79, 92)],
    size: ["XS", "S", "M"],
    description: "Hi",
    isCheck: true,
    category: "Kids",
  ),

  // 1
  AppModel(
    name: "Oversied FitPrinted T-shit",
    image:
        "https://drive.google.com/file/d/1LD5usmITAieAdjwtjqQFJd4VIO1tnd5i/view?usp=drive_link",
    rating: 4.9,
    price: 295,
    review: 136,
    fcolor: [Colors.black, Colors.blue, const Color.fromARGB(255, 65, 79, 92)],
    size: ["XS", "S", "M"],
    description: "",
    isCheck: true,
    category: "Baby",
  ),
];

final myDescription1 = "Elvate our casual wadrole with our";
final myDescription2 = "Crafted from premium for mximum cofort";
