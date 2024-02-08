import 'dart:convert';

List<TotalPriceModel> totalPriceModelFromJson(String str) => List<TotalPriceModel>.from(json.decode(str).map((x) => TotalPriceModel.fromJson(x)));

String totalPriceModelToJson(List<TotalPriceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalPriceModel {
  String? subTotal = '0.00';
  String? billDisc;
  String? total;
  String? taxable;
  String? vat;
  String? netAmount = '0.00';
  String? rcvdAmount;
  String? balance;
  String? itemDisc;
  String? recvdCurr;

  TotalPriceModel({
    this.subTotal,
    this.billDisc,
    this.total,
    this.taxable,
    this.vat,
    this.netAmount,
    this.rcvdAmount,
    this.balance,
    this.itemDisc,
    this.recvdCurr,
  });

  factory TotalPriceModel.fromJson(Map<String, dynamic> json) => TotalPriceModel(
    subTotal: json["subTotal"],
    billDisc: json["billDisc"],
    total: json["total"],
    taxable: json["taxable"],
    vat: json["vat"],
    netAmount: json["netAmount"],
    rcvdAmount: json["rcvdAmount"],
    balance: json["balance"],
    itemDisc: json["itemDisc"],
    recvdCurr: json["recvdCurr"],
  );

  Map<String, dynamic> toJson() => {
    "subTotal": subTotal,
    "billDisc": billDisc,
    "total": total,
    "taxable": taxable,
    "vat": vat,
    "netAmount": netAmount,
    "rcvdAmount": rcvdAmount,
    "balance": balance,
    "itemDisc": itemDisc,
    "recvdCurr": recvdCurr,
  };
}
