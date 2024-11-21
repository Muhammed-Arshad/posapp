import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/provider/home_provider/model/product_model.dart';
import 'package:posapp/provider/product_provider/all_products_provider.dart';
import 'package:posapp/provider/product_provider/model/all_products.dart';

class ProductNotifier extends StateNotifier<List<Product>>{
  Ref ref;
  ProductNotifier(this.ref): super([
    // Product(
    //   no: 1,
    //   itemCode: 'A001',
    //   itemName: 'Item 1',
    //   quantity: 1,
    //   amount: 20.0,
    //   totalAmount: 20.0,
    // ),
    // Product(
    //   no: 2,
    //   itemCode: 'A002',
    //   itemName: 'Item 2',
    //   quantity: 2,
    //   amount: 15.0,
    //   totalAmount: 30.0,
    // ),
  ]);


  void checkAndAddProduct(String barcode) {
    bool productFound = false;
    List<Product> updatedProducts = state.map((product) {
      if (product.itemCode == barcode) {
        productFound = true;
        double updatedQuantity = product.quantity + 1;

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

    final product = ref.read(productByCodeProvider(barcode));

    var newProduct = Product(
      no: state.length + 1,
      itemCode: barcode,
      itemName: product.productName.toString(),
      quantity: product.quantity.toDouble(),
      amount: product.amount,
      totalAmount: product.amount,
      productType: product.productType,
      productWeight: product.productWeight
    );

    state = [...state, newProduct];
  }

  void addProduct(productCode){
    final product = ref.read(productByCodeProvider(productCode));

    var newProduct = Product(
        no: state.length + 1,
        itemCode: productCode,
        itemName: product.productName.toString(),
        quantity: 1,
        amount: product.amount,
        totalAmount: 100.0,
        productType: product.productType
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
        // double updatedQuantity = product.quantity - 1;

        double updatedQuantity = 0;
        double totalAmount = 0;

        switch(targetProduct.productWeight){

          case ProductWeight.g:
            updatedQuantity = product.quantity - 100;
            totalAmount = product.amount * (updatedQuantity/100);
          case ProductWeight.kg:
            updatedQuantity = product.quantity - 0.25;
            totalAmount = product.amount* updatedQuantity;
          case ProductWeight.ml:
            updatedQuantity = product.quantity - 100;
            totalAmount = product.amount * (updatedQuantity/100);
          case ProductWeight.l:
            updatedQuantity = product.quantity - 0.25;
            totalAmount = product.amount* updatedQuantity;
        }

        return product.copyWith(
            quantity: updatedQuantity,
            totalAmount: totalAmount);
            // totalAmount: updatedQuantity * product.amount);
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

        double updatedQuantity = 0;
        double totalAmount = 0;

        switch(targetProduct.productWeight){

          case ProductWeight.g:
            updatedQuantity = product.quantity + 100;
            totalAmount = product.amount * (updatedQuantity/100);
          case ProductWeight.kg:
            updatedQuantity = product.quantity + 0.25;
            totalAmount = product.amount* updatedQuantity;
          case ProductWeight.ml:
            updatedQuantity = product.quantity + 100;
            totalAmount = product.amount * (updatedQuantity/100);
          case ProductWeight.l:
            updatedQuantity = product.quantity + 0.25;
            totalAmount = product.amount * updatedQuantity;
        }

        // double updatedQuantity = product.quantity + 1;
        return product.copyWith(
            quantity: updatedQuantity,
            // totalAmount: updatedQuantity * product.amount);
            totalAmount: totalAmount);
      }else {
        return product;
      }
    }).toList();
    state = updatedProducts;
    // getTotalPrice();
  }

  void addProductHelper(Product targetProduct,Product product){
    double updatedQuantity = 0;
    double totalAmount = 0;

    switch(targetProduct.productWeight){

      case ProductWeight.g:
        updatedQuantity = product.quantity + 100;
        totalAmount = product.amount * (updatedQuantity/100);
      case ProductWeight.kg:
        updatedQuantity = product.quantity + 0.25;
        totalAmount = product.amount* updatedQuantity;
      case ProductWeight.ml:
        updatedQuantity = product.quantity + 100;
        totalAmount = product.amount * (updatedQuantity/100);
      case ProductWeight.l:
        updatedQuantity = product.quantity + 0.25;
        totalAmount = product.amount * updatedQuantity;
    }
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

  String getMeasurement(Product p){
    switch(p.productWeight){
      case ProductWeight.g:
        return 'gram';
      case ProductWeight.kg:
        return 'Kg';
      case ProductWeight.ml:
        return 'ml';
      case ProductWeight.l:
        return 'L';
    }
  }


}

final productProvider = StateNotifierProvider<ProductNotifier, List<Product>>((ref) {

  return ProductNotifier(ref);
});




