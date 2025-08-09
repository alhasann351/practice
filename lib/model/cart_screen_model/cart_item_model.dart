import '../home_screen_model/products_model.dart';

class CartItemModel {
  final ProductsModel product;
  int quantity;

  CartItemModel({required this.product, this.quantity = 1});
}
