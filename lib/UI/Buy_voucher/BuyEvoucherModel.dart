
import 'dart:convert';

BuyEvoucherModel buyEvoucherModelFromJson(String str) => BuyEvoucherModel.fromJson(json.decode(str));

String buyEvoucherModelToJson(BuyEvoucherModel data) => json.encode(data.toJson());

class BuyEvoucherModel {
  BuyEvoucherModel({
    required this.status,
   // required this.minimumPurchaseAmt,
    required this.totalCartValue,
    required this.data,
  });

  String status;
 // String minimumPurchaseAmt;
  String totalCartValue;
  List<Datum> data;

  factory BuyEvoucherModel.fromJson(Map<String, dynamic> json) => BuyEvoucherModel(
    status: json["status"],
   // minimumPurchaseAmt: json["minimum_purchase_amt"],
    totalCartValue: json["total_cart_value"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
   // "minimum_purchase_amt": minimumPurchaseAmt,
    "total_cart_value": totalCartValue,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.programTitle,
    required this.programId,
    required this.imageUrl,
    required this.programValue,
    required this.colorCode,
    required this.displayVoucherName,
    required this.quantity,
    required this.maximumLimit,
  });

  String programTitle;
  String programId;
  String imageUrl;
  String programValue;
  String colorCode;
  String displayVoucherName;
  String quantity;
  String maximumLimit;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    programTitle: json["program_title"],
    programId: json["program_id"],
    imageUrl: json["image_url"],
    programValue: json["program_value"],
    colorCode: json["color_code"],
    displayVoucherName: json["display_voucher_name"],
    quantity: json["quantity"],
    maximumLimit: json["maximum_limit"],
  );

  Map<String, dynamic> toJson() => {
    "program_title": programTitle,
    "program_id": programId,
    "image_url": imageUrl,
    "program_value": programValue,
    "color_code": colorCode,
    "display_voucher_name": displayVoucherName,
    "quantity": quantity,
    "maximum_limit": maximumLimit,
  };


 Future Incrementnew(BuyEvoucherModel model,int index) async {
   var data = model.data[index];
   var intt = int.parse(data.quantity);
   intt += 1 ;
   var count = intt ;
   data.quantity = count.toString();

 }
}
