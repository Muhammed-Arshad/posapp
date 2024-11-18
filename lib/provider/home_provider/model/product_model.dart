import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int no;
  final String itemCode;
  final String itemName;
  final int quantity;
  final double amount;
  final double totalAmount;

  const Product({
    required this.no,
    required this.itemCode,
    required this.itemName,
    required this.quantity,
    required this.amount,
    required this.totalAmount,
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
    );
  }

  @override
  List<Object?> get props => [no, itemCode, itemName, quantity, amount, totalAmount];
}