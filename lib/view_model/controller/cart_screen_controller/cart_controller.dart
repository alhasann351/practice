import 'package:get/get.dart';
import 'package:practice/model/cart_screen_model/cart_model.dart';
import 'package:practice/model/home_screen_model/products_model.dart';

import '../../../data/response/status.dart';
import '../../../model/cart_screen_model/cart_item_model.dart';
import '../../../repository/cart_screen_repository/cart_screen_repository.dart';

class CartController extends GetxController {
  final _api = CartScreenRepository();
  final cartList = <CartModel>[].obs;
  final requestStatus = Status.loading.obs;
  final error = ''.obs;
  //final productsModel = <ProductsModel>[].obs;
  var cartItemsModel = <CartItemModel>[].obs;

  void setCartList(List<CartModel> carts) => cartList.value = carts;
  void setRequestStatus(Status status) => requestStatus.value = status;
  void setError(String errorMsg) => error.value = errorMsg;

  void addToCart(int productId, int quantity) {
    final newCart = {
      'userId': 20,
      'date': DateTime.now().toIso8601String().split("T")[0],
      'products': [
        {'productId': productId, 'quantity': quantity},
      ],
    };

    setRequestStatus(Status.loading);

    _api
        .cartApi(newCart)
        .then((value) {
          setRequestStatus(Status.completed);
          getCartItems();
        })
        .onError((error, stackTrace) {
          setRequestStatus(Status.error);
          setError(error.toString());
        });
  }

  void getCartItems() {
    _api
        .getCarts()
        .then((value) {
          setRequestStatus(Status.completed);
          setCartList(value);
        })
        .onError((error, stackTrace) {
          setRequestStatus(Status.error);
          setError(error.toString());
        });
  }

  ///=======add to cart list=====///
  var cartItems = <CartItemModel>[].obs;

  void addToCartInList(ProductsModel product) {
    int index = cartItems.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      Get.snackbar(
        "Notice",
        "Product already in cart",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      cartItems.add(CartItemModel(product: product));
      Get.snackbar(
        "Success",
        "Product added to cart",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
  }

  void incrementQuantity(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decrementQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    }
    cartItems.refresh();
  }

  double get totalPrice {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price! * item.quantity),
    );
  }

  int get cartCount => cartItems.fold(0, (sum, item) => sum + item.quantity);
}
