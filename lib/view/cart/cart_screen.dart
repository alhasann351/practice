/*import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/response/status.dart';
import '../../view_model/controller/cart_screen_controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final controller = Get.put(CartController());

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getCartItems();
    final productId = Get.arguments['id'];

    return Scaffold(
      appBar: AppBar(title: const Text("Cart List")),
      body: Obx(() {
        switch (controller.requestStatus.value) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.error:
            return Center(child: Text(controller.error.value));
          case Status.completed:
            return ListView.builder(
              itemCount: controller.cartList.length,
              itemBuilder: (context, index) {
                final cart = controller.cartList[index];
                return Card(
                  child: ListTile(
                    title: Text("User ID: ${cart.userId}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: cart.products!
                          .map(
                            (p) => Text(
                              "Product ID: ${p.productId}, Qty: ${p.quantity}",
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
            );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addToCart(productId, 10),
        child: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_model/controller/cart_screen_controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(child: Text("Cart is empty"));
        }
        return ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = cartController.cartItems[index];
            final itemTotalPrice = cartItem.product.price! * cartItem.quantity;

            return ListTile(
              leading: Image.network(cartItem.product.image ?? ''),
              title: Text(cartItem.product.title ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Unit Price: \$${cartItem.product.price!.toStringAsFixed(2)}',
                  ),
                  Text('Quantity: ${cartItem.quantity}'),
                  Text('Total Price: \$${itemTotalPrice.toStringAsFixed(2)}'),
                  //Text('Price: \$${cartItem.product.price}'),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            cartController.decrementQuantity(index),
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        '${cartItem.quantity}',
                      ), // ✅ এখানেই তুমি আগেও error পাচ্ছো
                      IconButton(
                        onPressed: () =>
                            cartController.incrementQuantity(index),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => cartController.removeFromCart(index),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${cartController.totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
