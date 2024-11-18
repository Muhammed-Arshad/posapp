import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/provider/home_provider/model/product_model.dart';

class ProductNotifier extends StateNotifier<List<Product>>{
  ProductNotifier(): super([
    Product(
      no: 1,
      itemCode: 'A001',
      itemName: 'Item 1',
      quantity: 1,
      amount: 20.0,
      totalAmount: 20.0,
    ),
    Product(
      no: 2,
      itemCode: 'A002',
      itemName: 'Item 2',
      quantity: 2,
      amount: 15.0,
      totalAmount: 30.0,
    ),
  ]);


  void checkAndAddProduct(String barcode) {
    bool productFound = false;
    List<Product> updatedProducts = state.map((product) {
      if (product.itemCode == barcode) {
        productFound = true;
        int updatedQuantity = product.quantity + 1;
        return product.copyWith(
            quantity: updatedQuantity,
            totalAmount: updatedQuantity * product.amount);
      }
      return product;
    }).toList();

    if (productFound) {
      state = updatedProducts;
      return;
    }

    var newProduct = Product(
      no: state.length + 1,
      itemCode: barcode,
      itemName: 'New Item',
      quantity: 1,
      amount: 100.0,
      totalAmount: 100.0,
    );

    state = [...state, newProduct];
  }


  void remove(Product product){
    state = state.where((p) => product != p).toList();
    getTotalPrice();
  }

  void removeProductCount(Product targetProduct){
    List<Product> updatedProducts = state.map((product) {
      if(product.itemCode == targetProduct.itemCode && product.quantity > 1) {
        int updatedQuantity = product.quantity - 1;
        return product.copyWith(
            quantity: updatedQuantity,
            totalAmount: updatedQuantity * product.amount);
      }else {
        return product;
      }
    }).toList();
    state = updatedProducts;
    // getTotalPrice();
  }

  void addProductCount(Product targetProduct){
    List<Product> updatedProducts = state.map((product) {
      if(product.itemCode == targetProduct.itemCode) {
        int updatedQuantity = product.quantity + 1;
        return product.copyWith(
            quantity: updatedQuantity,
            totalAmount: updatedQuantity * product.amount);
      }else {
        return product;
      }
    }).toList();
    state = updatedProducts;
    // getTotalPrice();
  }

  double getTotalPrice() {
    return state.fold(0.0, (sum, product) => sum + product.totalAmount);
  }

  void clicked(String num,TextEditingController ctrl){
    ctrl.text = ctrl.text + num;

    if(ctrl.text == '123' || ctrl.text == '456'){

      checkAndAddProduct(ctrl.text);
      ctrl.clear();

    }
  }


}

final productProvider = StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
  return ProductNotifier();
});




