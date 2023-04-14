import 'dart:convert';


List<WhatsOnMultipleInitModel> whatsOnMultipleInitModelFromJson(String str) =>
    List<WhatsOnMultipleInitModel>.from(json.decode(str).map((x) => WhatsOnMultipleInitModel.fromJson(x)));
String HomeMultipleInitModelToJson(List<WhatsOnMultipleInitModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class WhatsOnMultipleInitModel {
  WhatsOnMultipleInitModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
   // required this.categoryAction,
    required this.bannerType,
    /*required this.displayLabel,
    required this.details,
    required this.errorMessage,
    required this.subCount,
    required this.programid,
    required this. expiry,
   required this. programtype,
    required this.  poketed,
    required this. cangift,
    required this. cardimage,
    required this. merchantid,*/
  });

  var categoryId;
  var categoryName;
  var categoryImage;
  var categoryAction;
  var bannerType;
  var displayLabel;
  var details;
  var errorMessage;
  var subCount;
var programid;
var  expiry;
var programtype;
var  poketed;
var cangift;
var cardimage;
var merchantid;


  factory WhatsOnMultipleInitModel.fromJson(Map<String, dynamic> json) => WhatsOnMultipleInitModel(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
   // categoryAction: json["category_action"],
    bannerType: json["subbannertype"],
  /*  displayLabel: json["displaylabel"],
    details: json["details"],
    programid: json["program_id"],
    expiry: json["Expiry"],
    programtype: json["program_type"],
    poketed:json["Poketed"],
    cangift: json["can_gift"],
    cardimage:json["Card_Image"],
    merchantid:json["merchant_id"],
    errorMessage: json["errormessage"],
    subCount: json["sub_count"],
*/
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "category_image": categoryImage,
   // "category_action": categoryAction,
    "subbannertype": bannerType,
    /*"displaylabel": displayLabel,
    "details": details,
    "program_id" :programid,
    "Expiry": expiry,
  "program_type": programtype,
   "Poketed": poketed,
   "can_gift":cangift,
   "Card_Image":cardimage,
   "merchant_id": merchantid,
    "errormessage": errorMessage,
    "sub_count": subCount,

*/

  };


}