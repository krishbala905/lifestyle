import 'dart:convert';



List<Catlogmodel> CatlogmodeFromJson(String str) =>
    List<Catlogmodel>.from(json.decode(str).map((x) => Catlogmodel.fromJson(x)));
String CatlogmodeToJson(List<Catlogmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Catlogmodel {
  Catlogmodel({
    required this.Cat_ID,
    required this.Cat_Image,
    required this.Cat_Name,
    required this.bannerType,


  });

  var Cat_ID,Cat_Image,Cat_Name,bannerType;


  factory Catlogmodel.fromJson(Map<String, dynamic> json) => Catlogmodel(
    Cat_ID: json["Cat_ID"],
    Cat_Image: json["Cat_Image"],
    Cat_Name: json["Cat_Name"],
    bannerType: json["bannerType"],

  );

  Map<String, dynamic> toJson() => {
    "Cat_ID": Cat_ID,
    "Cat_Image": Cat_Image,
    "Cat_Name": Cat_Name,
    "bannerType":bannerType,


  };


}
