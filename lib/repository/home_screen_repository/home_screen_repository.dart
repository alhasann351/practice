import '../../data/network/network_api_services.dart';
import '../../model/home_screen_model/products_model.dart';
import '../../resource/app_url/app_url.dart';

class HomeScreenRepository {
  final _apiService = NetworkApiServices();

  Future<List<ProductsModel>> productsListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.productsApi);
    List<ProductsModel> productsList = (response as List)
        .map((json) => ProductsModel.fromJson(json))
        .toList();
    return productsList;
  }
}
