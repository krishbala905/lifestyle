import 'dart:convert';



List<Walletmodel> WalletmodeFromJson(String str) =>
    List<Walletmodel>.from(json.decode(str).map((x) => Walletmodel.fromJson(x)));
String WalletmodeToJson(List<Walletmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Walletmodel {
  Walletmodel({
    required this.programID,
    required this.merchantID,
    required this.voucherNo ,
    required this.giftVoucherStripes,
    required this.databaseID,
    required this.countryIndex,
    required this.programType,


  });

  var programID,merchantID,voucherNo ,giftVoucherStripes,databaseID,countryIndex,programType;


  factory Walletmodel.fromJson(Map<String, dynamic> json) => Walletmodel(
    programID: json["programID"],
    merchantID: json["merchantID"],
    voucherNo : json["voucherNo "],
    giftVoucherStripes: json["giftVoucherStripes"],
    databaseID: json["databaseID"],
    countryIndex: json["countryIndex"],
    programType: json["programType"],

  );

  Map<String, dynamic> toJson() => {
    "programID": programID,
    "merchantID": merchantID,
    "voucherNo ": voucherNo ,
    "giftVoucherStripes":giftVoucherStripes,
    "databaseID":databaseID,
    "countryIndex":countryIndex,
    "programType":programType,


  };


}
