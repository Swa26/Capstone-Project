import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final stateProvider =
    ChangeNotifierProvider<CartProvider>((ref) => CartProvider());

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> cartList = [];
  final List<Map<String, dynamic>> cartList2 = [];
  final List<Map<String, dynamic>> orderedCakes = [];
  int totalPrice = 0;

  void addProduct(Map<String, dynamic> product) {
    cartList.add(product);
    cartList2.add(product);
    notifyListeners();
  }

  void removeproduct(Map<String, dynamic> product) {
    cartList.remove(product);
    cartList2.remove(product);
    notifyListeners();
  }

  void empty(List<Map<String, dynamic>> cartList) {
    cartList.clear();
    notifyListeners();
  }
}
