import 'package:equatable/equatable.dart';

import '../../home_provider/model/product_model.dart';

// enum ProductType {veg, nonVeg, fruits, other}
// enum ProductUnit { g, kg, ml, l }

class AllProduct extends Equatable {
  final int no;
  final String productCode;
  final String productName;
  final int quantity;
  final double price;
  final ProductType productType;
  final ProductUnit productUnit;

  const AllProduct({
    required this.no,
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.price,
    this.productType = ProductType.veg,
    this.productUnit = ProductUnit.g
  });

  AllProduct copyWith({
    int? no,
    String? productCode,
    String? productName,
    int? quantity,
    double? price,
    ProductType? productType,
    ProductUnit? productUnit,
  }) {
    return AllProduct(
      no: no ?? this.no,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      productType: productType ?? this.productType,
      productUnit: productUnit ?? this.productUnit,
    );
  }

  @override
  List<Object?> get props => [no, productCode, productName, quantity, price,
    productType,productUnit];
}