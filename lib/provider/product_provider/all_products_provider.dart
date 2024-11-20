import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/all_products.dart';

class AllProductNotifier extends StateNotifier<List<AllProduct>>{
  AllProductNotifier(): super([
    AllProduct(no: 1, productCode: "123", productName: "Sugar", quantity: 1, amount: 30, productType: ProductType.other),
    AllProduct(no: 2, productCode: "124", productName: "Chilly", quantity: 2, amount: 40),
    AllProduct(no: 3, productCode: "125", productName: "Tomato", quantity: 5, amount: 70),
    AllProduct(no: 4, productCode: "126", productName: "Onion", quantity: 5, amount: 20),
    AllProduct(no: 5, productCode: "127", productName: "Ginger", quantity: 5, amount: 100),
    AllProduct(no: 6, productCode: "128", productName: "Biscuit", quantity: 5, amount: 80),
  ]);


}

final allProductProvider = StateNotifierProvider<AllProductNotifier, List<AllProduct>>((ref) {
  return AllProductNotifier();
});

final productByCodeProvider = Provider.family<AllProduct, String>((ref, productCode) {
  final allProducts = ref.read(allProductProvider);
  return allProducts.firstWhere(
        (product) => product.productCode == productCode,
    // orElse: () => null,
  );
});