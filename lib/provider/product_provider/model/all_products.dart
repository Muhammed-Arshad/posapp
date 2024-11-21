import 'package:equatable/equatable.dart';

enum ProductType {veg, nonVeg, fruits, other}
enum ProductWeight { g, kg, ml, l }

class AllProduct extends Equatable {
  final int no;
  final String productCode;
  final String productName;
  final int quantity;
  final double amount;
  final ProductType productType;
  final ProductWeight productWeight;

  const AllProduct({
    required this.no,
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.amount,
    this.productType = ProductType.veg,
    this.productWeight = ProductWeight.g
  });

  AllProduct copyWith({
    int? no,
    String? productCode,
    String? productName,
    int? quantity,
    double? amount,
    ProductType? productType,
    ProductWeight? productWeight,
  }) {
    return AllProduct(
      no: no ?? this.no,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      productType: productType ?? this.productType,
      productWeight: productWeight ?? this.productWeight,
    );
  }

  @override
  List<Object?> get props => [no, productCode, productName, quantity, amount,
    productType,productWeight];
}