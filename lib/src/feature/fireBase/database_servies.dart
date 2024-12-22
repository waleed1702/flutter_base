import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod_base/src/models/m_products.dart';

class DataBaseService {
  final databse = FirebaseFirestore.instance;

  void create(DbProducts product) {
    databse.collection('products').add(product.toMap());
  }

  List<DbProducts> getProducts() {
    final products = <DbProducts>[];
    databse.collection('products').get().then((value) {
      for (final product in value.docs) {
        products.add(DbProducts.fromMap(product.data()));
      }
    });
    return products;
  }

  void update(DbProducts product) {
    databse.collection('products').doc(product.id).update(product.toMap());
  }

  void delete(DbProducts product) {
    databse.collection('products').doc(product.id).delete();
  }
}
