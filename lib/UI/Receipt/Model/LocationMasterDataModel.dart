import 'dart:convert';


List<LocationMasterDataModel> LocationMasterDataModelFromJson(String str) =>
    List<LocationMasterDataModel>.from(json.decode(str).map((x) => LocationMasterDataModel.fromJson(x)));
String LocationMasterDataModelToJson(List<LocationMasterDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class LocationMasterDataModel {
  LocationMasterDataModel({
    required this.name,
    required this.id,


  }

  );

  String name;
  var id;


  factory LocationMasterDataModel.fromJson(Map<String, dynamic> json) => LocationMasterDataModel(
    name: json["name"],
    id: json["id"],

  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,

  };


}