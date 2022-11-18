// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_shop/const.dart';
import 'package:pet_shop/models/category_model.dart';
import 'package:pet_shop/models/product_model.dart';

import '../widgets/categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Foods';
  List<CategoryModel> dataCategory = [];
  List<ProductModel> dataProduct = [];

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

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  void dispose() {
    getCategory();
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

      body: Column(
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
                      fontSize: 25, color: black, fontWeight: FontWeight.bold),
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
        ],
      ),
    );
  }
}

