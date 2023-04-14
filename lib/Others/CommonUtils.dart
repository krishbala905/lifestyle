
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';



void showToast(String msg, {int? duration, int? gravity}) {

  Toast.show(msg, duration: duration, gravity: gravity);
}
void hideKeyboard(){
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

getRandomNumberBetweenAndToCharacter() {
  int min = 71;
  int max = 90;
  Random foo = new Random();
  int randomNumber = foo.nextInt(max - min) + min;
  if (randomNumber == min) {
    return (min + 1);
  } else {
    return randomNumber;
  }
}

class CommonUtils{
  static String  cid="" ,merid="",mername="",msgid="",msgtype="",msgsubtype="",msgsenddate="",
      msgreadstatus="",msgtitile="",merchlogo="";
  static  bool NetworkStatus = true;
  static  String NAVIGATE_PATH = "none";
  static  String KEY_FORCE_UPDATE = "force_update";
  static  String KEY_FORCE_LOG_OUT = "forcelogout";
  static  String KEY_WALLET_SYNC = "walletsync";
  static  String KEY_WALLET_SYNC_NEW = "walletsyncnew";
  static  String KEY_CALL_INBOX = "callinbox";
  static  String KEY_NEWSONLY = "newsonly";
  static  String KEY_CARD = "rm";
  static  String KEY_VOUCHER = "rv";
  static  String KEY_MEMBER_POINT_TRANSACTION = "mpt";
  static  String KEY_REMOVE_GIFT_VOUCHER = "rgv";
  static  String KEY_GIFT_VOUCHER = "gv";

  static  String KEY_FEEDBACK_POINT_TRANSACTION = "event_fb_pt";
  static  String KEY_MEMBERSHIP_POPUP = "show_membership_popup";
  static  String KEY_REWARD_REDEEM = "bioderma_pointvc_redeem";
  static  String UPDATE_POINTS= "updatepoints";

  static  String none = "none";
  static  String rewards_popup = "rewardsPopup";
  static  String memberShip_popup = "membershipPopup";
  static  String inboxPage = "inboxPage";
  static  String walletPage = "walletPage";
  static  String homePage = "homePage";
  static  String rewardsPage = "rewardsPage";
  static  String buyVoucherPage = "BUYVOUCHER";

  static String ROAD_ASSIST_WITH_CALL = "roadassistwithcall";
  static String ROAD_ASSIST_WITHOUT_CALL = "roadassistwithoutcall";
  static String triggerUrl="triggerurl";
  static String triggerPhone="triggerphone";
  static String triggerCMS="cms";
  static String triggerPDF="triggerPDF";
  static String triggerNormal="normal";
  static String triggerVoucher= "voucher";
  static String triggerEmail="triggeremail";
  static String triggerOneSubbaner="onesubbanner";
  static String MerchantId="";
  static  int QRVERSION = 1;
  static  int APPLICATIONID = 1;
  static  int SELECTEDLANGUAGEPACKAGEID = 1;
  static String? APPLICATIONLANGUAGEID = " ";
  static String? APPLICATIONLANGUAGECOUNTRY = " ";
  static String DEVICE_HUWAEI_AAID = "";
  static String DEVICE_HUWAEI_APPID = "";
  static String DEVICE_HUWAEI_TOKEN = "";
  static String pid = "0";
  static int new_huwavei_device= 0;

  static String? currentUserFB_AccessToken="";
  static String? currentUseremail="";
  static String? currentUserLastname="";
  static String? consumerID="";
  static String? currentUserprofilepicture="";
  static String? currentUserFirstname="";
  static String? currentUserFB_ID="";
  static String? currentUsername="";
  static String? consumerforcelogout="";
  static String? merchantID=" ";
  static String? consumerName="";
  static String? consumercountrycode="";
  static String? consumerGender="";
  static String? consumerProfileImageUrl="";
  static String? consumermobileNumber="";
  static String? consumerDateofBirth="";
  static String? consumerIntialScreen="";
  static String? consumerEmail="";
  static String? deviceTokenID="";
  static String? COUNTRY_INDEX="65";
  static String? deviceToken="";
  static String? deviceType="";
  static String? deviceModel="";
  static String? manufacturer="";
  static String? osVersion="";
  static String? softwareVersion="1.0.32";
  static String? timeStamp="";
  static String? consumeraddress="";
  static String? consumerpostalcode="";
  static String? timeZone="";
  static String? merchantId="318";
  static String? consumerApplicationType="1";
  static String? consumerLanguageId="1";
  static var PPN_RESPONSE_CONTENT;
  static var SelectedWallet_SortBy = "newest";

  static var imageFileForReceipt;
  static String? imageFileName;

  static String MultipleBannerDetailPageId="0";
  static String MultipleBannerDetailPageTittle="";
  static List programtype=[];
  static int isSecondImagePresent=0;
  static var imageFileForReceipt1;
  static String? imageFileName1;

}



