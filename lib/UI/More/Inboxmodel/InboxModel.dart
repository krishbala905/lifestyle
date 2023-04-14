

import 'dart:convert';

List<InboxModel> InboxModelFromJson(String str) =>
    List<InboxModel>.from(json.decode(str).map((x) => InboxModel.fromJson(x)));
String InboxModelToJson(List<InboxModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class InboxModel {
  InboxModel({
  required this.MERCHANT_ID,
  required this. MERCHANT_NAME,
  required this. MERCHANT_URL ,
  required this. MESSAGE_TITLE,
  required this. MESSAGE_ID ,
  required this. MESSAGE_SEND_DATE,
  required this. READ_STATUS ,
  required this. MESSAGE_TYPE,
  required this. VALID_UNTIL ,
  required this. COUNTRY_INDEX ,
  required this. MESSAGE_SUB_TYPE ,
 // required this. INBOX_COUNT,

  });

  var MERCHANT_ID,
   MERCHANT_NAME,
  MERCHANT_URL ,
   MESSAGE_TITLE,
  MESSAGE_ID ,
  MESSAGE_SEND_DATE,
  READ_STATUS ,
  MESSAGE_TYPE,
   VALID_UNTIL ,
  COUNTRY_INDEX ,
  MESSAGE_SUB_TYPE ;
 // INBOX_COUNT;


  factory InboxModel.fromJson(Map<String, dynamic> json) => InboxModel(
  MERCHANT_ID: json["MERCHANT_ID"],
  MERCHANT_NAME: json["MERCHANT_NAME"],
  MERCHANT_URL : json["MERCHANT_URL"],
  MESSAGE_TITLE:json["MESSAGE_TITLE"],
  MESSAGE_ID :json["MESSAGE_ID"],
  MESSAGE_SEND_DATE:json["MESSAGE_SEND_DATE"],
  READ_STATUS :json["READ_STATUS"],
  MESSAGE_TYPE:json["MESSAGE_TYPE"],
  VALID_UNTIL :json["VALID_UNTIL"],
  COUNTRY_INDEX :json["COUNTRY_INDEX"],
  MESSAGE_SUB_TYPE :json["MESSAGE_SUB_TYPE"],
 // INBOX_COUNT:json["INBOX_COUNT"],

  );

  Map<String, dynamic> toJson() => {
  "MERCHANT_ID": MERCHANT_ID,
  "MERCHANT_NAME":  MERCHANT_NAME,
  "MERCHANT_URL":  MERCHANT_URL ,
  "MESSAGE_TITLE":  MESSAGE_TITLE,
  "MESSAGE_ID": MESSAGE_ID ,
  "MESSAGE_SEND_DATE": MESSAGE_SEND_DATE,
  "READ_STATUS": READ_STATUS ,
  "MESSAGE_TYPE": MESSAGE_TYPE,
  "VALID_UNTIL": VALID_UNTIL ,
  "COUNTRY_INDEX": COUNTRY_INDEX ,
  "MESSAGE_SUB_TYPE": MESSAGE_SUB_TYPE ,
  // "INBOX_COUNT":INBOX_COUNT,

  };


}
