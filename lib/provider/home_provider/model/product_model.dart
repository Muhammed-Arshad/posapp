import 'package:equatable/equatable.dart';
import 'package:posapp/provider/product_provider/model/all_products.dart';

class Product extends Equatable {
  final int no;
  final String itemCode;
  final String itemName;
  final double quantity;
  final double amount;
  final double totalAmount;
  final ProductType productType;
  final ProductWeight productWeight;

  const Product({
    required this.no,
    required this.itemCode,
    required this.itemName,
    required this.quantity,
    required this.amount,
    required this.totalAmount,
    this.productType = ProductType.veg,
    this.productWeight = ProductWeight.g,
  });

  Product copyWith({
    int? no,
    String? itemCode,
    String? itemName,
    double? quantity,
    double? amount,
    double? totalAmount,
    ProductWeight? productWeight,
  }) {
    return Product(
      no: no ?? this.no,
      itemCode: itemCode ?? this.itemCode,
      itemName: itemName ?? this.itemName,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      totalAmount: totalAmount ?? this.totalAmount,
      productType: productType,
      productWeight: productWeight ?? this.productWeight,
    );
  }

  @override
  List<Object?> get props => [no, itemCode, itemName, quantity,
    amount, totalAmount,productType,productWeight];

  @override
  String toString() {
    return 'Product(no: $no, itemCode: $itemCode, itemName: $itemName,'
        ' quantity: $quantity, amount: $amount, totalAmount: $totalAmount,'
        ' productType: $productType, productWeight: $productWeight)';
  }
}