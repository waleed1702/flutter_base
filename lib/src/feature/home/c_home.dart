import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod_base/src/feature/fireBase/database_servies.dart';
import 'package:flutter_riverpod_base/src/feature/login/controller/login_controller.dart';
import 'package:flutter_riverpod_base/src/models/m_products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = StateNotifierProvider<ControllerHome, List<DbProducts>>(
  (ref) {
    return ControllerHome();
  },
);

class ControllerHome extends StateNotifier<List<DbProducts>> {
  List products = [];
  final _dataBaseService = DataBaseService();
  ControllerHome() : super([]) {
    getProducts();
  }

  void getProducts() async {
    state.addAll(_dataBaseService.getProducts());
  }

  void addProduct(
    DbProducts product,
    String userid,
  ) {
    product.id = userid;
    _dataBaseService.create(product);
    state.add(product);
  }

  void removeProduct(DbProducts product) {
    _dataBaseService.delete(product);
    state.remove(product);
  }

  void updateProduct(DbProducts product) {
    _dataBaseService.update(product);
    state[state.indexWhere((element) => element.id == product.id)] = product;
  }
}
