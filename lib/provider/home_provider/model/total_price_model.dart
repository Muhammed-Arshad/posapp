import 'dart:convert';

List<TotalPriceModel> totalPriceModelFromJson(String str) => List<TotalPriceModel>.from(json.decode(str).map((x) => TotalPriceModel.fromJson(x)));

String totalPriceModelToJson(List<TotalPriceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalPriceModel {
  String? subTotal;
  String? billDisc;
  String? total;
  String? taxable;
  String? vat;

  TotalPriceModel({
    this.subTotal,
    this.billDisc,
    this.total,
    this.taxable,
    this.vat,
  });

  factory TotalPriceModel.fromJson(Map<String, dynamic> json) => TotalPriceModel(
    subTotal: json["subTotal"],
    billDisc: json["billDisc"],
    total: json["total"],
    taxable: json["taxable"],
    vat: json["vat"],
  );

  Map<String, dynamic> toJson() => {
    "subTotal": subTotal,
    "billDisc": billDisc,
    "total": total,
    "taxable": taxable,
    "vat": vat,
  };
}
