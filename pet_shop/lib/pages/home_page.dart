// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_shop/const.dart';
import 'package:pet_shop/models/category_model.dart';
import 'package:pet_shop/models/product_model.dart';

import '../widgets/categories.dart';
import '../widgets/product_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Foods';
  List<CategoryModel> dataCategory = [];
  List<ProductModel> dataProduct = [];
  List<IconData> icons = [
    Icons.home_filled,
    Icons.favorite_border_rounded,
    Icons.chat_outlined,
    Icons.person_outline_rounded
  ];
  List<String> labels = [
    'Home',
    'Favorites',
    'Messages',
    'Profile'
  ];
  int selectedPage = 0;
  Future<void> getCategory() async {
    final String response =
        await rootBundle.loadString('assets/json/category.json');
    final data = json.decode(response);
    setState(() {
      for (var element in data['category']) {
        dataCategory.add(CategoryModel.fromJson(element));
      }
    });
  }

  Future<void> getProducts() async {
    final String response =
        await rootBundle.loadString('assets/json/product.json');
    final data = json.decode(response);
    setState(() {
      for (var element in data['product']) {
        dataProduct.add(ProductModel.fromJson(element));
      }
    });
  }

  @override
  void initState() {
    getCategory();
    getProducts();
    super.initState();
  }

  @override
  void dispose() {
    getCategory();
    getProducts();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      //   elevation: 0,
      //   leading: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      //     child: Text(
      //       'Petshop',
      //       style: poppin.copyWith(
      //           fontSize: 25, color: black, fontWeight: FontWeight.bold),
      //     ),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      //       child: Icon(
      //         Icons.shopping_cart_outlined,
      //         color: Colors.black,
      //       ),
      //     ),
      //   ],
      // ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Petshop',
                    style: poppin.copyWith(
                        fontSize: 25,
                        color: black,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: grey.withOpacity(0.2),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search food, accessories etc ...',
                    hintStyle: poppin.copyWith(
                      color: deepPurple.withOpacity(0.6),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    prefixIconColor: deepPurple,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  dataCategory.length,
                  (index) => Padding(
                    padding: index == 0
                        ? const EdgeInsets.only(left: 20, right: 20)
                        : const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = dataCategory[index].text!;
                        });
                      },
                      child: CategoryItem(
                        category: dataCategory[index],
                        selectedCategory: selectedCategory,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            //Products
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Best Seller",
                    style: poppin.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                  ),
                  Text(
                    "See All",
                    style: poppin.copyWith(
                      fontSize: 14,
                      color: deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            //Products Listing
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  dataProduct.length,
                  (index) => Padding(
                    padding: index == 0
                        ? EdgeInsets.only(left: 20, right: 20)
                        : EdgeInsets.only(right: 20),
                    child: ProductItem(
                      product: dataProduct[index],
                    ),
                  ),
                ),
              ),
            ),
            //Special Bundles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Special Bundles",
                    style: poppin.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                  ),
                  Text(
                    "See All",
                    style: poppin.copyWith(
                      fontSize: 14,
                      color: deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //Special Bundles Listing
            SizedBox(
              // color: blue,
              height: 150,
              width: MediaQuery.of(context).size.width - 40,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: purple.withOpacity(0.4),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: -10,
                    child: Transform.rotate(
                      angle: -0.15,
                      child: Image.asset(
                        'assets/foods/meow-mix1.png',
                        height: 120,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 50,
                    child: Transform.rotate(
                      angle: 0.3,
                      child: Image.asset(
                        'assets/foods/authority1.png',
                        height: 120,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 20,
                    child: Transform.rotate(
                      angle: 0,
                      child: Image.asset(
                        'assets/foods/royal-canin1.png',
                        height: 120,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 190,
                    top: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Special Bundle',
                          style: poppin.copyWith(
                            fontSize: 16,
                            color: deepPurple,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Special offer\n Three in one',
                          style: poppin.copyWith(
                            fontSize: 14,
                            color: white,
                          ),
                        ),
                        Text(
                          '\$${40.00}',
                          style: poppin.copyWith(
                            fontSize: 20,
                            color: black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        child: BottomNavigationBar(
          backgroundColor: white,
          selectedItemColor: deepPurple,
          unselectedItemColor: grey,
          elevation: 1,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              selectedPage = value;
            });
          },
          items: List.generate(
            icons.length,
            (index) => BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      icons[index],
                      color: selectedPage == index ? deepPurple : grey,
                    ),
                    const SizedBox(height: 5),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: selectedPage == index ? 15 : 0,
                      height: selectedPage == index ? 3 : 0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: deepPurple),
                    )
                  ],
                ),
              label: '',
            ),
          ),
        ),
      ),
    );
  }
}
