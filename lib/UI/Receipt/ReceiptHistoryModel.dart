import 'dart:convert';

import 'package:lifestyle/UI/Receipt/ReceiptHistory.dart';


List<ReceiptHistoryModel> receiptHistoryModelFromJson(String str) =>
    List<ReceiptHistoryModel>.from(json.decode(str).map((x) => ReceiptHistoryModel.fromJson(x)));
String ReceiptHistoryModelToJson(List<ReceiptHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ReceiptHistoryModel {
  ReceiptHistoryModel({
    required this.shopName,
    required this.status,
    required this.creditedPoint,
    required this.receiptDate,
    required this.receiptNo,
    required this.receiptId,

  });

   var shopName,status,creditedPoint,receiptDate,receiptNo,receiptId;


  factory ReceiptHistoryModel.fromJson(Map<String, dynamic> json) => ReceiptHistoryModel(
    shopName: json["shopName"],
    status: json["status"],
    creditedPoint: json["creditedPoint"],
    receiptDate: json["receiptDate"],
    receiptNo: json["receiptNo"],
    receiptId: json["receiptId"],
  );

  Map<String, dynamic> toJson() => {
    "shopName": shopName,
    "status": status,
    "creditedPoint": creditedPoint,
    "receiptDate": receiptDate,
    "receiptNo": receiptNo,
    "receiptId": receiptId,

  };


}