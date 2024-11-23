import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/provider/home_provider/model/product_model.dart';
import 'package:posapp/provider/product_provider/all_products_provider.dart';
import 'package:posapp/provider/product_provider/model/all_products.dart';

class ProductNotifier extends StateNotifier<List<Product>>{
  Ref ref;
  ProductNotifier(this.ref): super([]);


  void checkAndAddProduct(String barcode) {
    bool productFound = false;
    List<Product> updatedProducts = state.map((product) {
      if (product.productCode == barcode) {
        productFound = true;
        double updatedQuantity = product.quantity + 1;

        return product.copyWith(
            quantity: updatedQuantity,
            totalAmount: updatedQuantity * product.price);
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
      productCode: barcode,
      productName: product.productName.toString(),
      quantity: product.quantity.toDouble(),
      price: product.price,
      fixedPrice: product.price,
      fixedUnit: product.productUnit,
      totalAmount: product.price,
      productType: product.productType,
      productUnit: product.productUnit,
      dateTime: DateTime.now()
    );

    state = [...state, newProduct];
  }

  void addProduct(productCode){
    final product = ref.read(productByCodeProvider(productCode));

    var newProduct = Product(
        no: state.length + 1,
        productCode: productCode,
        productName: product.productName.toString(),
        quantity: 1,
        price: product.price,
        fixedPrice: product.price,
        fixedUnit: product.productUnit,
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
      if(product.productCode == targetProduct.productCode && product.quantity > 1) {
        // double updatedQuantity = product.quantity - 1;

        double updatedQuantity = 0;
        double totalAmount = 0;

        switch(targetProduct.productUnit){

          case ProductUnit.g:
            updatedQuantity = product.quantity - 100;
            totalAmount = product.price * (updatedQuantity/100);
          case ProductUnit.kg:
            updatedQuantity = product.quantity - 0.25;
            totalAmount = product.price* updatedQuantity;
          case ProductUnit.ml:
            updatedQuantity = product.quantity - 100;
            totalAmount = product.price * (updatedQuantity/100);
          case ProductUnit.l:
            updatedQuantity = product.quantity - 0.25;
            totalAmount = product.price* updatedQuantity;
        }

        return product.copyWith(
            quantity: updatedQuantity,
            totalAmount: totalAmount);
            // totalAmount: updatedQuantity * product.price);
      }else {
        return product;
      }
    }).toList();
    state = updatedProducts;
    // getTotalPrice();
  }

  void addProductCount(Product targetProduct){
    List<Product> updatedProducts = state.map((product) {
      if(product.productCode == targetProduct.productCode) {

        double updatedQuantity = 0;
        double totalAmount = 0;

        switch(targetProduct.productUnit){

          case ProductUnit.g:
            updatedQuantity = product.quantity + 100;
            totalAmount = product.price * (updatedQuantity/100);
          case ProductUnit.kg:
            updatedQuantity = product.quantity + 0.25;
            totalAmount = product.price* updatedQuantity;
          case ProductUnit.ml:
            updatedQuantity = product.quantity + 100;
            totalAmount = product.price * (updatedQuantity/100);
          case ProductUnit.l:
            updatedQuantity = product.quantity + 0.25;
            totalAmount = product.price * updatedQuantity;
        }

        return product.copyWith(
            quantity: updatedQuantity,
            totalAmount: totalAmount);
      }else {
        return product;
      }
    }).toList();
    state = updatedProducts;
  }

  void updateProductQuantity(updatedQuantity,Product tProduct,
      ProductUnit unit) async {

    List<Product> updatedProducts = state.map((product) {
      if(product.productCode == tProduct.productCode) {

        double totalAmount = 0;
        double unitPrice = 0;

        if(tProduct.fixedUnit == ProductUnit.kg || tProduct.fixedUnit == ProductUnit.l){
          unitPrice = (tProduct.fixedPrice/1000);
        }else{
          unitPrice = (tProduct.fixedPrice/100);
        }

        switch(unit){

          case ProductUnit.g:
            totalAmount = unitPrice * updatedQuantity;
          case ProductUnit.kg:
            totalAmount = unitPrice * (updatedQuantity * 1000);
          case ProductUnit.ml:
            totalAmount = unitPrice * updatedQuantity;
          case ProductUnit.l:
            totalAmount = unitPrice * (updatedQuantity * 1000);
        }

        return product.copyWith(
            quantity: updatedQuantity,
            productUnit: unit,
            totalAmount: totalAmount);
      }else {
        return product;
      }
    }).toList();
    state = updatedProducts;
  }

  void addProductHelper(Product targetProduct,Product product){
    double updatedQuantity = 0;
    double totalAmount = 0;

    switch(targetProduct.productUnit){

      case ProductUnit.g:
        updatedQuantity = product.quantity + 100;
        totalAmount = product.price * (updatedQuantity/100);
      case ProductUnit.kg:
        updatedQuantity = product.quantity + 0.25;
        totalAmount = product.price* updatedQuantity;
      case ProductUnit.ml:
        updatedQuantity = product.quantity + 100;
        totalAmount = product.price * (updatedQuantity/100);
      case ProductUnit.l:
        updatedQuantity = product.quantity + 0.25;
        totalAmount = product.price * updatedQuantity;
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

  String getQuantityUnit(Product p){
    switch(p.productUnit){
      case ProductUnit.g:
        return 'gram';
      case ProductUnit.kg:
        return 'Kg';
      case ProductUnit.ml:
        return 'ml';
      case ProductUnit.l:
        return 'L';
    }
  }

  String getFixedUnit(Product p){
    switch(p.fixedUnit){
      case ProductUnit.g:
        return '/g';
      case ProductUnit.kg:
        return '/Kg';
      case ProductUnit.ml:
        return '/ml';
      case ProductUnit.l:
        return '/L';
    }
  }

  void clearProducts() {
    state = [];
  }

  var focusNode = FocusNode();


}

final productProvider = StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
  return ProductNotifier(ref);
});




