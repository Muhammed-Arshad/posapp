import 'package:hive/hive.dart';
import '../../home_provider/model/product_model.dart';
part 'all_products.g.dart';

// enum ProductType {veg, nonVeg, fruits, other}
// enum ProductUnit { g, kg, ml, l }

@HiveType(typeId: 3) // Assign a unique type ID
class AllProduct extends HiveObject {
  @HiveField(0)
  final int no;

  @HiveField(1)
  final String productCode;

  @HiveField(2)
  final String productName;

  @HiveField(3)
  final double quantity;

  @HiveField(4)
  final double price;

  @HiveField(5)
  final ProductType productType;

  @HiveField(6)
  final ProductUnit productUnit;

  @HiveField(7)
  final DateTime? dateTime;

  AllProduct({
    required this.no,
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.price,
    this.productType = ProductType.veg,
    this.productUnit = ProductUnit.g,
    this.dateTime
  });

  AllProduct copyWith({
    int? no,
    String? productCode,
    String? productName,
    double? quantity,
    double? price,
    ProductType? productType,
    ProductUnit? productUnit,
    DateTime? dateTime
  }) {
    return AllProduct(
      no: no ?? this.no,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      productType: productType ?? this.productType,
      productUnit: productUnit ?? this.productUnit,
      dateTime: dateTime ?? this.dateTime,
    );
  }

}