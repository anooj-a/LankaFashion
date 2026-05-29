import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/Provider/Models/model.dart';
import 'package:flutter_application_1/Core/Provider/Models/category_model.dart';
import 'package:flutter_application_1/Core/Common/Utils/colors.dart';
import 'package:flutter_application_1/Views/Role_based_login/User/Screen/Items_detail_screen/Screen/items_detail_screen.dart';
import 'package:flutter_application_1/Core/Provider/Models/sub_category.dart';
import 'package:iconsax/iconsax.dart';

class CategoryItems extends StatelessWidget {
  String category;
  List<AppModel> categoryItems;
  CategoryItems({
    super.key,
    required this.category,
    required this.categoryItems,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: fbackgroundColor2,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          hintText: "Search in $category",
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                          filled: true,
                          fillColor: Colors.transparent,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(
                            Iconsax.search_normal,
                            color: Colors.black54,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    filterCategory.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black12),
                          color: index == 0 ? Colors.black : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Text(
                              filterCategory[index],
                              style: TextStyle(
                                color: index == 0 ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              index == 0 ? Icons.filter_list : Icons.keyboard_arrow_down,
                              size: 16,
                              color: index == 0 ? Colors.white : Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  ...List.generate(
                    subcategory.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: fbackgroundColor1,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(subcategory[index].image),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              subcategory[index].name,
                              style: const TextStyle(fontSize: 12, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: categoryItems.isEmpty
                  ? Center(
                      child: Text(
                        "No items available in this category.",
                        style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: categoryItems.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final item = categoryItems[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ItemsDetailScreen(
                                  eCommerceApp: item,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Hero(
                                  tag: item.image,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: fbackgroundColor2,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: item.image.startsWith('http')
                                            ? NetworkImage(item.image) as ImageProvider
                                            : AssetImage(item.image),
                                      ),
                                    ),
                                    height: size.height * 0.25,
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: CircleAvatar(
                                            radius: 16,
                                          backgroundColor: Colors.black26,
                                            child: Icon(
                                              Icons.favorite_border,
                                              color: Colors.black87,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "H&M",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 14,
                                      ),
                                      Text(
                                        item.rating.toString(),
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.black87,
                                  height: 1.3,
                                ),
                              ),

                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    "\$${item.price.toString()}.00",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  if (item.isCheck == true) ...[
                                    const SizedBox(width: 8),
                                    Text(
                                      "\$${item.price + 255}.00",
                                      style: TextStyle(
                                        color: Colors.grey.shade400,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}