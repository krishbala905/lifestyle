import 'dart:convert';



List<WalletViewmodel> WalletmodeFromJson(String str) =>
    List<WalletViewmodel>.from(json.decode(str).map((x) => WalletViewmodel.fromJson(x)));
String WalletmodeToJson(List<WalletViewmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class WalletViewmodel {
  var merchantName;

  var merchantID;

  var merchantEmail;

  var programPoints;

  var displayTitleFlag;

  var sroSettings;

  var merchantSubCategory;

  var outletAddress;

  var merchantCategory;

  var upgradeRequirement;

  var programCategory;

  var merchantWebsite;

  var displayLogoFlag;

  var merchantLogoURL;

  var programTextColor;

  var outletName;
  var outletList;

  var outletIDList;

  var outletContact;

  var outletBuiding;

  var outletOpHours;
  var serialnumber;

  //var bundleFormat;

  var memberID;
var programtype;
var giftvoucherstripe;
  WalletViewmodel({
    required this.programBackgroundImgURL,
    required this.programTitle,
    required this.programExpiryDate ,
    required this.tnc,
    required this.benefits,
    required this.countryIndex,
    required this.programID,
    required this.merchantName,
    required this.merchantID,
    required this.merchantEmail,
    required this.merchantWebsite,
    required this.merchantLogoURL,
    required this.displayLogoFlag,
    required this.merchantCategory,
    required this.merchantSubCategory,
    required this.programTextColor,
    required this.sroSettings,
    required this.displayTitleFlag,
    required this.programCategory,
    required this.programPoints,
    required this.upgradeRequirement,
    required this.outletList,
    required this.outletName,
    required this.outletIDList,
    required this.outletContact,
    required this.outletAddress,
    required this.outletBuiding,
    required this.outletOpHours,
    //required this.bundleFormat,
    required this.memberID,
    required this.serialnumber,
   required this.programtype,
   required this.giftvoucherstripe,



  });

  var programBackgroundImgURL,programTitle,programExpiryDate ,tnc,benefits,countryIndex,programID;


  factory WalletViewmodel.fromJson(Map<String, dynamic> json) => WalletViewmodel(
    programBackgroundImgURL: json["programBackgroundImgURL"],
    programTitle: json["programTitle"],
    programExpiryDate : json["programExpiryDate "],
    tnc: json["tnc"],
    benefits: json["benefits"],
    countryIndex: json["countryIndex"],
    programID: json["programID"],
      merchantName:json["merchantName"],
      merchantID:json["merchantID"],
      merchantEmail:json["merchantEmail"],
      merchantWebsite:json["merchantWebsite"],
      merchantLogoURL:json["merchantLogoURL"],
      displayLogoFlag:json["displayLogoFlag"],
      merchantCategory:json["merchantCategory"],
      merchantSubCategory:json["merchantSubCategory"],
      programTextColor:json["programTextColor"],
      sroSettings:json["sroSettings"],
      displayTitleFlag:json["displayTitleFlag"],
      programCategory: json["programCategory"],
      programPoints: json["programCategory"],
      upgradeRequirement: json["programCategory"],
    outletList: json["outletList"],
      outletName: json["outletName"],
      outletIDList:json["outletIDList"],
      outletContact:json["outletContact"],
      outletAddress:json["outletAddress"],
      outletBuiding: json["outletBuiding"],
      outletOpHours:json["outletOpHours"],
     // bundleFormat:json["outletOpHours"],
      memberID: json["memberID"],
    serialnumber: json["serialnumber"],
     programtype:json["programtype"],
     giftvoucherstripe:json["giftvoucherstripe"],
  );

  Map<String, dynamic> toJson() => {
    "programBackgroundImgURL": programBackgroundImgURL,
    "programTitle": programTitle,
    "programExpiryDate ": programExpiryDate ,
    "tnc":tnc,
    "benefits":benefits,
    "countryIndex":countryIndex,
    "programID":programID,
  "merchantName":merchantName,
  "merchantID":merchantID,
  "merchantEmail":merchantEmail,
  "merchantWebsite": merchantWebsite,
  "merchantLogoURL":merchantLogoURL,
  "displayLogoFlag":displayLogoFlag,
  "merchantCategory":merchantCategory,
  "merchantSubCategory":merchantSubCategory,
  "programTextColor":programTextColor,
  "sroSettings":sroSettings,
  "displayTitleFlag":displayTitleFlag,
  "programCategory": programCategory,
  "programPoints":programPoints,
  "upgradeRequirement":upgradeRequirement,
  "outletList":outletList,
  "outletName":outletName,
  "outletIDList":outletIDList,
  "outletContact":outletContact,
  "outletAddress":outletAddress,
  "outletBuiding":outletBuiding,
  "outletOpHours":outletOpHours,
  //"bundleFormat":bundleFormat,
  "memberID":memberID,
  "serialnumber":serialnumber,
"programtype":programtype,
   "giftvoucherstripe":giftvoucherstripe,
  };


}
