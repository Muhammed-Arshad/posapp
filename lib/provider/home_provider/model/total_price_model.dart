
class TotalPriceModel {
  String? subTotal;
  String? billDisc;
  String? total;
  String? taxable;
  String? vat;
  String? netAmount;
  String? rcvdAmount;
  String? balance;
  String? itemDisc;
  String? recvdCurr;

  TotalPriceModel({
    this.subTotal = '0.00',
    this.billDisc,
    this.total,
    this.taxable,
    this.vat,
    this.netAmount = '0.00',
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

  TotalPriceModel copyWith({
    String? subTotal,
    String? billDisc,
    String? total,
    String? taxable,
    String? vat,
    String? netAmount,
    String? rcvdAmount,
    String? balance,
    String? itemDisc,
    String? recvdCurr,
  }) {
    return TotalPriceModel(
      subTotal: subTotal ?? this.subTotal,
      billDisc: billDisc ?? this.billDisc,
      total: total ?? this.total,
      taxable: taxable ?? this.taxable,
      vat: vat ?? this.vat,
      netAmount: netAmount ?? this.netAmount,
      rcvdAmount: rcvdAmount ?? this.rcvdAmount,
      balance: balance ?? this.balance,
      itemDisc: itemDisc ?? this.itemDisc,
      recvdCurr: recvdCurr ?? this.recvdCurr,
    );
  }
}