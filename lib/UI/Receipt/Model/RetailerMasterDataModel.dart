import 'dart:convert';


List<RetailerMasterDataModel> RetailerMasterDataModelFromJson(String str) =>
    List<RetailerMasterDataModel>.from(json.decode(str).map((x) => RetailerMasterDataModel.fromJson(x)));
String RetailerMasterDataModelToJson(List<RetailerMasterDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class RetailerMasterDataModel {
  RetailerMasterDataModel({
    required this.Retailername,
    required this.Categ,
    required this.Retailerid,

  }

  );

  String Retailername;
  var Categ;

  var Retailerid;


  factory RetailerMasterDataModel.fromJson(Map<String, dynamic> json) => RetailerMasterDataModel(
    Retailername: json["cat_id"],
    Categ: json["item_data"],

    Retailerid: json["cat_name"],

  );

  Map<String, dynamic> toJson() => {
    "cat_id": Retailername,
    "item_data": Categ,

    "cat_name": Retailerid,

  };


}