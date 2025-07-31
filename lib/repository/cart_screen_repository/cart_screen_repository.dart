import '../../data/network/network_api_services.dart';
import '../../model/cart_screen_model/cart_model.dart';
import '../../resource/app_url/app_url.dart';

class CartScreenRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> cartApi(dynamic data) async {
    dynamic response = await _apiService.postApi(data, AppUrl.cartApi);
    return response;
  }

  Future<List<CartModel>> getCarts() async {
    final response = await _apiService.getApi(AppUrl.cartApi);
    List<CartModel> cartList = (response as List)
        .map((json) => CartModel.fromJson(json))
        .toList();
    return cartList;
  }
}
