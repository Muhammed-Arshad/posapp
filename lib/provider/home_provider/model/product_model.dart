import 'package:equatable/equatable.dart';
import 'package:posapp/provider/product_provider/model/all_products.dart';

class Product extends Equatable {
  final int no;
  final String itemCode;
  final String itemName;
  final int quantity;
  final double amount;
  final double totalAmount;
  final ProductType productType;

  const Product({
    required this.no,
    required this.itemCode,
    required this.itemName,
    required this.quantity,
    required this.amount,
    required this.totalAmount,
    this.productType = ProductType.veg,
  });

  Product copyWith({
    int? no,
    String? itemCode,
    String? itemName,
    int? quantity,
    double? amount,
    double? totalAmount,
  }) {
    return Product(
      no: no ?? this.no,
      itemCode: itemCode ?? this.itemCode,
      itemName: itemName ?? this.itemName,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      totalAmount: totalAmount ?? this.totalAmount,
      productType: productType ?? this.productType,
    );
  }

  @override
  List<Object?> get props => [no, itemCode, itemName, quantity, amount, totalAmount,productType];
}