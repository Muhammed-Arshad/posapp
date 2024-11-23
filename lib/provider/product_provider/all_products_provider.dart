import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home_provider/model/product_model.dart';
import 'model/all_products.dart';

class AllProductNotifier extends StateNotifier<List<AllProduct>>{
  Ref ref;
  AllProductNotifier(this.ref): super([
    AllProduct(no: 1, productCode: "123", productName: "Sugar", quantity: 1, price: 60, productType: ProductType.other, productUnit: ProductUnit.kg),
    AllProduct(no: 2, productCode: "124", productName: "Chilly", quantity: 100, price: 40, productType: ProductType.other, productUnit: ProductUnit.g),
    AllProduct(no: 3, productCode: "125", productName: "Tomato", quantity: 1, price: 70, productType: ProductType.veg, productUnit: ProductUnit.kg),
    AllProduct(no: 4, productCode: "126", productName: "Onion", quantity: 1, price: 20, productType: ProductType.veg, productUnit: ProductUnit.kg),
    AllProduct(no: 5, productCode: "127", productName: "Ginger", quantity: 100, price: 100, productType: ProductType.veg, productUnit: ProductUnit.g),
    AllProduct(no: 6, productCode: "128", productName: "Biscuit", quantity: 100, price: 80, productType: ProductType.other, productUnit: ProductUnit.g),
    AllProduct(no: 7, productCode: "129", productName: "Potato", quantity: 1, price: 50, productType: ProductType.veg, productUnit: ProductUnit.kg),
    AllProduct(no: 8, productCode: "130", productName: "Chicken", quantity: 1, price: 200, productType: ProductType.nonVeg, productUnit: ProductUnit.kg),
    AllProduct(no: 9, productCode: "131", productName: "Apple", quantity: 1, price: 150, productType: ProductType.fruits, productUnit: ProductUnit.kg),
    AllProduct(no: 10, productCode: "132", productName: "Banana", quantity: 1, price: 60, productType: ProductType.fruits, productUnit: ProductUnit.kg),
    AllProduct(no: 11, productCode: "133", productName: "Carrot", quantity: 1, price: 30, productType: ProductType.veg, productUnit: ProductUnit.kg),
    AllProduct(no: 12, productCode: "134", productName: "Fish", quantity: 1, price: 250, productType: ProductType.nonVeg, productUnit: ProductUnit.kg),
    AllProduct(no: 13, productCode: "135", productName: "Milk", quantity: 1, price: 50, productType: ProductType.other, productUnit: ProductUnit.l),
    AllProduct(no: 14, productCode: "136", productName: "Rice", quantity: 1, price: 300, productType: ProductType.other, productUnit: ProductUnit.kg),
    AllProduct(no: 15, productCode: "137", productName: "Wheat Flour", quantity: 1, price: 80, productType: ProductType.other, productUnit: ProductUnit.kg),
    AllProduct(no: 16, productCode: "138", productName: "Salt", quantity: 1, price: 20, productType: ProductType.other, productUnit: ProductUnit.kg),
    AllProduct(no: 17, productCode: "139", productName: "Eggs", quantity: 1, price: 70, productType: ProductType.nonVeg, productUnit: ProductUnit.g),
    AllProduct(no: 18, productCode: "140", productName: "Mango", quantity: 1, price: 100, productType: ProductType.fruits, productUnit: ProductUnit.kg),
    AllProduct(no: 19, productCode: "141", productName: "Broccoli", quantity: 1, price: 80, productType: ProductType.veg, productUnit: ProductUnit.kg),
    AllProduct(no: 20, productCode: "142", productName: "Cheese", quantity: 100, price: 120, productType: ProductType.other, productUnit: ProductUnit.g),
    AllProduct(no: 21, productCode: "143", productName: "Yogurt", quantity: 100, price: 20, productType: ProductType.other, productUnit: ProductUnit.ml),

  ]);


  void filterProducts(String query) {
    List<AllProduct> filter = [];
    filter =  state.where((product) =>
      product.productName.toLowerCase().contains(query.toLowerCase()) ||
          product.productCode.toLowerCase().contains(query.toLowerCase()))
          .toList();

    ref.read(filterProductProvider.notifier).state = filter;
  }

  void pressCloseOrSeeAll(String button){
    if(button == 'close'){
      ref.read(filterProductProvider.notifier).state = [];
    }else{

    }
  }


}

final allProductProvider = StateNotifierProvider<AllProductNotifier, List<AllProduct>>((ref) {
  return AllProductNotifier(ref);
});

final productByCodeProvider = Provider.family<AllProduct, String>((ref, productCode) {
  final allProducts = ref.read(allProductProvider);
  return allProducts.firstWhere(
        (product) => product.productCode == productCode,
    // orElse: () => null,
  );
});

final filterProductProvider = StateProvider<List<AllProduct>>((ref){
  return <AllProduct>[];
});
