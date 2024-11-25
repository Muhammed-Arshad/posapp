import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 1) // Use a unique typeId for each enum
enum ProductType {
  @HiveField(0)
  veg,

  @HiveField(1)
  nonVeg,

  @HiveField(2)
  fruits,

  @HiveField(3)
  other,
}

@HiveType(typeId: 2) // Use a unique typeId for each enum
enum ProductUnit {
  @HiveField(0)
  g,

  @HiveField(1)
  kg,

  @HiveField(2)
  ml,

  @HiveField(3)
  l,
}

@HiveType(typeId: 0) // Use unique typeId for each class.
class Product extends HiveObject {
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
  final double fixedPrice;

  @HiveField(6)
  final ProductUnit fixedUnit;

  @HiveField(7)
  final double totalAmount;

  @HiveField(8)
  final ProductType productType;

  @HiveField(9)
  final ProductUnit productUnit;

  @HiveField(10)
  final DateTime? dateTime;

  Product({
    required this.no,
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.fixedPrice,
    required this.fixedUnit,
    required this.totalAmount,
    this.productType = ProductType.veg,
    this.productUnit = ProductUnit.g,
    this.dateTime
  });

  Product copyWith({
    int? no,
    String? productCode,
    String? productName,
    double? quantity,
    double? price,
    double? fixedPrice,
    ProductUnit? fixedUnit,
    double? totalAmount,
    ProductType? productType,
    ProductUnit? productUnit,
    DateTime? dateTime,
  }) {
    return Product(
      no: no ?? this.no,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      fixedPrice: fixedPrice ?? this.fixedPrice,
      fixedUnit: fixedUnit ?? this.fixedUnit,
      totalAmount: totalAmount ?? this.totalAmount,
      productType: productType ?? this.productType,
      productUnit: productUnit ?? this.productUnit,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  @override
  List<Object?> get props => [no, productCode, productName, quantity,
    price, fixedPrice, fixedUnit, totalAmount,productType,productUnit,dateTime];

  @override
  String toString() {
    return 'Product(no: $no, itemCode: $productCode, productName: $productName,'
        ' quantity: $quantity, amount: $price, totalAmount: $totalAmount,'
        ' productType: $productType, productWeight: $productUnit)';
  }
}