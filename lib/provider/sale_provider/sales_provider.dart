import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../home_provider/model/product_model.dart';

class SalesNotifier extends StateNotifier<List<Product>>{
  Ref ref;
  final Box<Product> _salesBox;
  SalesNotifier(this.ref,this._salesBox):super(_salesBox.values.toList());

  void addToSale(List<Product> p){
    // state = [...p,...state];
    // // _salesBox.put('sales', state);
    //
    // for (var product in p) {
    //   final uniqueKey = '${product.productCode}_${DateTime.now().millisecondsSinceEpoch}';
    //   _salesBox.put(uniqueKey, product);
    //   // _salesBox.put(product.productCode, product); // Use product ID as the key
    // }

    for (var product in p) {
      _salesBox.add(product); // Automatically appends in insertion order
    }
    state = _salesBox.values.toList();
  }

  void deleteProduct(int index) {
    if (index < 0 || index >= _salesBox.length) {
      return; // Index out of bounds
    }
    _salesBox.deleteAt(index); // Deletes the product at the given index
    state = _salesBox.values.toList(); // Update the state
  }

  void editProduct(int index, Product updatedProduct) {
    if (index < 0 || index >= _salesBox.length) {
      return; // Index out of bounds
    }
    _salesBox.putAt(index, updatedProduct); // Update the product at the given index
    state = _salesBox.values.toList(); // Update the state
  }

  // void getSalesPrint(){
  //   state.where((p)=> p.productCode == )
  // }

  void getSalesPrint() {
    // Create a map to aggregate products by their productCode
    final salesMap = <String, Product>{};

    for (var product in state) {
      if (salesMap.containsKey(product.productCode)) {
        // If the productCode already exists, update quantity and totalPrice
        final existingProduct = salesMap[product.productCode]!;
        salesMap[product.productCode] = Product(
          no: existingProduct.no,
          productName: existingProduct.productName,
          productCode: existingProduct.productCode,
          price: existingProduct.price,
          quantity: existingProduct.quantity + product.quantity,
          totalAmount: existingProduct.totalAmount + product.totalAmount,
          fixedPrice: existingProduct.price,
          fixedUnit: existingProduct.productUnit,
          // Add other fields if necessary
        );
        print('ARSHAD----');
        print(salesMap);
      } else {
        // If the productCode doesn't exist, add it to the map
        salesMap[product.productCode] = product;
        print('MUHAMMED----');
        print(salesMap);
      }
    }

    // Update the state with the consolidated list
    // state = salesMap.values.toList();
  }


  void clearSales() {
    state = [];
    _salesBox.clear();
  }
}


final salesProvider = StateNotifierProvider<SalesNotifier, List<Product>>((ref) {
  final salesBox = Hive.box<Product>('sales');
  return SalesNotifier(ref,salesBox);
});

final selectedMenuProvider = StateProvider.autoDispose<int>((ref){
  return 0;
});