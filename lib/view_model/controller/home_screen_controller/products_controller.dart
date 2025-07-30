import 'package:get/get.dart';

import '../../../data/response/status.dart';
import '../../../model/home_screen_model/products_model.dart';
import '../../../repository/home_screen_repository/home_screen_repository.dart';

class ProductsController extends GetxController {
  final _api = HomeScreenRepository();
  final requestStatus = Status.loading.obs;
  final productsList = <ProductsModel>[].obs;
  final error = ''.obs;

  void setRequestStatus(Status status) => requestStatus.value = status;
  void setProductsList(List<ProductsModel> products) =>
      productsList.value = products;
  void setError(String errorMsg) => error.value = errorMsg;

  void getProductsList() {
    _api
        .productsListApi()
        .then((value) {
          setRequestStatus(Status.completed);
          setProductsList(value);
        })
        .onError((error, stackTrace) {
          setRequestStatus(Status.error);
          setError(error.toString());
        });
  }
}
