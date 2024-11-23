import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../home_provider/model/product_model.dart';

class SalesNotifier extends StateNotifier<List<Product>>{
  Ref ref;
  final Box<Product> _salesBox;
  SalesNotifier(this.ref,this._salesBox):super(_salesBox.values.toList());

  void addToSale(List<Product> p){
    state = [...p,...state];
    for (var product in p) {
      _salesBox.put(product.productCode, product); // Use product ID as the key
    }
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