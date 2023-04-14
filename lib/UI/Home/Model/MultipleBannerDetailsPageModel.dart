import 'dart:convert';



List<MutlipleBannerDetailsPagemodel> CatlogmodeFromJson(String str) =>
    List<MutlipleBannerDetailsPagemodel>.from(json.decode(str).map((x) => MutlipleBannerDetailsPagemodel.fromJson(x)));
String CatlogmodeToJson(List<MutlipleBannerDetailsPagemodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class MutlipleBannerDetailsPagemodel {
  MutlipleBannerDetailsPagemodel({
    required this.Cat_Url,
    required this.Cat_Image,
    required this.Cat_Name,


  });

  var Cat_Url,Cat_Image,Cat_Name;


  factory MutlipleBannerDetailsPagemodel.fromJson(Map<String, dynamic> json) => MutlipleBannerDetailsPagemodel(
    Cat_Url: json["Cat_Url"],
    Cat_Image: json["Cat_Image"],
    Cat_Name: json["Cat_Name"],


  );

  Map<String, dynamic> toJson() => {
    "Cat_Url": Cat_Url,
    "Cat_Image": Cat_Image,
    "Cat_Name": Cat_Name,



  };


}
