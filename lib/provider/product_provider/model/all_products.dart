import 'package:equatable/equatable.dart';

enum ProductType {veg, nonVeg, fruits, other}

class AllProduct extends Equatable {
  final int no;
  final String productCode;
  final String productName;
  final int quantity;
  final double amount;
  final ProductType productType;

  const AllProduct({
    required this.no,
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.amount,
    this.productType = ProductType.veg
  });

  AllProduct copyWith({
    int? no,
    String? productCode,
    String? productName,
    int? quantity,
    double? amount,
    ProductType? productType,
  }) {
    return AllProduct(
      no: no ?? this.no,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      productType: productType ?? this.productType,
    );
  }

  @override
  List<Object?> get props => [no, productCode, productName, quantity, amount, productType];
}