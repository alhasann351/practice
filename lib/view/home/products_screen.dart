import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/response/status.dart';
import '../../resource/route/route_name.dart';
import '../../view_model/controller/cart_screen_controller/cart_controller.dart';
import '../../view_model/controller/home_screen_controller/products_controller.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final productsController = Get.put(ProductsController());
  final cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    productsController.getProductsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA2AF9B),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Products',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(RouteName.cartScreen);
                },
                icon: const Icon(
                  Icons.add_shopping_cart_outlined,
                  color: Colors.white,
                ),
              ),
              Obx(
                () => Positioned(
                  top: 0,
                  right: 6,
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        cartController.cartCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          switch (productsController.requestStatus.value) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(child: Text(productsController.error.value));
            case Status.completed:
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.45,
                ),
                padding: const EdgeInsets.all(10),
                itemCount: productsController.productsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(
                        RouteName.cartScreen,
                        arguments: {
                          'id': productsController.productsList[index].id,
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Image.network(
                            productsController.productsList[index].image
                                .toString(),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            productsController.productsList[index].title
                                .toString(),
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            productsController.productsList[index].description
                                .toString(),
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            'Price: \$${productsController.productsList[index].price.toString()}',
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.star, color: Colors.redAccent),
                              const Icon(Icons.star, color: Colors.redAccent),
                              const Icon(Icons.star, color: Colors.redAccent),
                              const Icon(Icons.star, color: Colors.redAccent),
                              const Icon(
                                Icons.star_border,
                                color: Colors.redAccent,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                productsController
                                    .productsList[index]
                                    .rating!
                                    .rate
                                    .toString(),
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              cartController.addToCartInList(
                                productsController.productsList[index],
                              );
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.add_shopping_cart,
                                size: 30,
                                color: Colors.green[300],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
          }
        }),
      ),
    );
  }
}
