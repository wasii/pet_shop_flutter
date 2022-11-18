// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pet_shop/const.dart';
import 'package:pet_shop/models/product_model.dart';



class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3 + 50,
      width: MediaQuery.of(context).size.width * 0.5 - 30,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.5 - 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 2),
                      color: black.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 5,
                    )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        left: 20,
                        right: 20,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: product.color!,
                                offset: Offset.zero,
                                spreadRadius: 5,
                                blurRadius: 25,
                              ),
                            ]
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/foods/${product.image}',
                        height: 180,
                      ),
                    ],
                  ),
                ),
                Text(
                  product.name!,
                  style: poppin.copyWith(
                    fontSize: 16,
                    color: black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '\$${product.price}',
                  style: poppin.copyWith(
                    fontSize: 18,
                    color: black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: green,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '+',
                  style: poppin.copyWith(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
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
