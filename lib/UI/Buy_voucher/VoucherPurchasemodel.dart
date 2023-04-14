// To parse this JSON data, do
//
//     final purcahsevoucherList = purcahsevoucherListFromJson(jsonString);

import 'dart:convert';

PurcahsevoucherList purcahsevoucherListFromJson(String str) => PurcahsevoucherList.fromJson(json.decode(str));

String purcahsevoucherListToJson(PurcahsevoucherList data) => json.encode(data.toJson());

class PurcahsevoucherList {
  PurcahsevoucherList({
    required this.status,
    required this.totalCartValue,
    required this.totalAmount,
    required this.minPurchaseAmt,
    required this.data,
  });

  String status;
  String totalCartValue;
 String totalAmount;
  String minPurchaseAmt;
  List<Datum> data;

  factory PurcahsevoucherList.fromJson(Map<String, dynamic> json) => PurcahsevoucherList(
    status: json["status"],
    totalCartValue: json["total_cart_value"],
    totalAmount: json["total_amount"],
    minPurchaseAmt: json["min_purchase_amt"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total_cart_value": totalCartValue,
    "total_amount": totalAmount,
    "min_purchase_amt": minPurchaseAmt,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.programTitle,
    required this.programId,
    required this.imageUrl,
    required this.programValue,
    required this.discountApplied,
    required this.displayVoucherName,
    required this.quantity,
    required this.indTotalAmt,
    required this.maximumLimit,
  });

  String programTitle;
  String programId;
  String imageUrl;
  String programValue;
  String discountApplied;
  String displayVoucherName;
  String quantity;
  String indTotalAmt;
  String maximumLimit;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    programTitle: json["program_title"],
    programId: json["program_id"],
    imageUrl: json["image_url"],
    programValue: json["program_value"],
    discountApplied: json["discount_applied"],
    displayVoucherName: json["display_voucher_name"],
    quantity: json["quantity"],
    indTotalAmt: json["ind_total_amt"],
    maximumLimit: json["maximum_limit"],
  );

  Map<String, dynamic> toJson() => {
    "program_title": programTitle,
    "program_id": programId,
    "image_url": imageUrl,
    "program_value": programValue,
    "discount_applied": discountApplied,
    "display_voucher_name": displayVoucherName,
    "quantity": quantity,
    "ind_total_amt": indTotalAmt,
    "maximum_limit": maximumLimit,
  };
}
