import 'dart:convert';
import 'dart:io';

import 'package:lifestyle/Others/AlertDialogUtil.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/Others/NativeAlertDialog.dart';
import 'package:lifestyle/Others/Utils.dart';
import 'package:lifestyle/UI/ConsumerTab.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifestyle/Others/Urls.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:xml2json/xml2json.dart';

import '../../res/Strings.dart';

class RewardsDetailFragement extends StatefulWidget {
  var programid,
      merchantid,
      outletId,
      programname,
      programtype,
      isDownload,
      categoryid;
  RewardsDetailFragement(
    this.programid,
    this.merchantid,
    this.outletId,
    this.programname,
    this.programtype,
    this.isDownload,
    this.categoryid, {
    Key? key,
  }) : super(key: key);

  @override
  State<RewardsDetailFragement> createState() => _RewardsDetailFragementState(
      this.programid,
      this.merchantid,
      this.outletId,
      this.programname,
      this.programtype,
      this.isDownload,
      this.categoryid);
}

class _RewardsDetailFragementState extends State<RewardsDetailFragement> {
  bool ShowDescription = true;
  bool ShowTermsTxt = true;
  var programid,
      merchantid,
      outletId,
      programname,
      programtype,
      isDownload,
      categoryid;
  var programType, outletID;
  _RewardsDetailFragementState(this.programid, this.merchantid, this.outletId,
      this.programname, this.programtype, this.isDownload, this.categoryid);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
          appBar: AppBar(
              title: Text("Cathay Lifestyle"), backgroundColor: Maincolor),
          body: Column(
            children: [
              Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    child: _GetRewardsDetailBuilder(context),
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      /*Models.Points == " "? Text("Requires " + "0" +" points"):
                  Text("Requires " + Models.Points +" points"),*/
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextButton(
                          onPressed: () {
                            //_DownloadVoucher(programid, categoryid[0]);
                            if (CommonUtils.consumeraddress.toString() != "none" &&
                                CommonUtils.consumercountrycode.toString() != "none") {
                              _DownloadVoucher(programid, categoryid[0]);
                            } else {
                              showAlertDialog_oneBtn(context, alert, "Update your mailing address and postal code under profile for product redemption");
                            }
                          },
                          child: Text(
                            "REDEEM",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Maincolor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                //side: BorderSide(color: Colors.red)
                              ))),
                        ),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
  void showAlertDialog_oneBtnWitDismissw(
      BuildContext context, String tittle, String message) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text(tittle),
      // content: CircularProgressIndicator(),
      content: Text(message, style: TextStyle(color: Colors.black45)),
      actions: [
        GestureDetector(
          onTap: () {
            CommonUtils.NAVIGATE_PATH = "walletPage";
            //  Navigator.pop(context,true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ConsumerTab(),
              ),
            );
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 35,
              width: 100,
              color: Colors.white,
              child: Center(
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Maincolor),
                  )),
            ),
          ),
        ),
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((exit) {
      if (exit == null) return;

      if (exit) {
        // back to previous screen

        Navigator.pop(context);
      } else {
        // user pressed No button
      }
    });
  }
  Future<dynamic> _GetRewardsDetail() async {
    final http.Response response =
        await http.post(Uri.parse(REWARDS_DETAIL_URL), body: {
      "consumer_id": CommonUtils.consumerID.toString(),
      "program_id": programid,
      "program_type": programtype,
      "country_index": "65",
      "merchant_id": merchantid,
    }).timeout(Duration(seconds: 30));

    debugPrint("CatlogueBanner:" + response.body);
    final Xml2Json xml2json = new Xml2Json();
    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var data = jsonDecode(jsonstring);
    var newData = data['info'];

    return newData;
  }

  FutureBuilder<dynamic> _GetRewardsDetailBuilder(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: _GetRewardsDetail(),
        builder: (context, Snapchat) {
          if (Snapchat.data != null) {
            final dynamic? posts = Snapchat.data;
            return _BuildRewardsDetail(context, posts!);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _BuildRewardsDetail(BuildContext, var post) {
    // bool ShowDescription = false;
    // String decription=Utils().stringSplit(post["p2"]);
    String expirydetails = Utils().stringSplit(post["p1"]);
    String benefits = Utils().stringSplit(post["p2"]);
    String terms = Utils().stringSplit(post["p4"]);
    String merchantinfo = Utils().stringSplit(post["p5"]);
    outletID = Utils().stringSplit(post["p6"]);
    String outletName = Utils().stringSplit(post["p7"]);
    String outletBuiding = Utils().stringSplit(post["p8"]);
    String outletAddress = Utils().stringSplit(post["p9"]);
    String outletLongLat = Utils().stringSplit(post["p10"]);
    String outletOpHours = Utils().stringSplit(post["p11"]);
    String outletContact = Utils().stringSplit(post["p12"]);
    String programImageURLs = Utils().stringSplit(post["p13"]);
    String merchantLogoURL = Utils().stringSplit(post["p14"]);
    String merchantName = Utils().stringSplit(post["p15"]);
    String merchantSubCategory = Utils().stringSplit(post["p16"]);
    var merchantRating = Utils().stringSplit(post["p17"]);
    if (merchantRating.toString() == "none") {
      merchantRating = "0";
    }
    String merchantEmail = Utils().stringSplit(post["p18"]);
    String merchantWebsite = Utils().stringSplit(post["p19"]);
    var merchantGalleryURLs = Utils().stringSplit(post["p20"]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26, width: 1),
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Image.network(
                programImageURLs,
                fit: BoxFit.fill,
              )),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          height: 1,
          child: Container(
            color: poketPurple,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            programname,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: poketPurple),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Expiry: " + expirydetails,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          height: 1,
          child: Container(
            color: poketPurple,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Benefits",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: poketPurple),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                  onTap: () {
                    print("hellooo");
                    setState(() {
                      ShowDescription = !ShowDescription;
                    });
                  },
                  child: ShowDescription == false
                      ? Image.asset(
                          "assets/ic_more.png",
                          width: 20,
                          height: 20,
                        )
                      : Image.asset(
                          "assets/ic_less.png",
                          width: 20,
                          height: 20,
                        )),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Visibility(
            visible: ShowDescription,
            child: Text(
              benefits,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 1,
          child: Container(
            color: poketPurple,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Terms",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: poketPurple),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                  onTap: () {
                    print("hellooo");
                    setState(() {
                      ShowTermsTxt = !ShowTermsTxt;
                    });
                  },
                  child: ShowTermsTxt == false
                      ? Image.asset(
                          "assets/ic_more.png",
                          width: 20,
                          height: 20,
                        )
                      : Image.asset(
                          "assets/ic_less.png",
                          width: 20,
                          height: 20,
                        )

                  // icon_plus
                  ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Visibility(
            visible: ShowTermsTxt,
            child: Text(
              terms.replaceAll("\\n", "\n"),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _DownloadVoucher(var programID, Cat_Id) async {
    //  print(Models.Points.toString());
    print(programID);
    print(programtype);
    print(Cat_Id);
    if (programtype != 4) {
      programType = programtype.toString();
    } else {
      programType = 3;
      programType = "gv";
    }
    print(REWARDS_DOWNLOAD_URL);
    final http.Response response =
    await http.post(Uri.parse(REWARDS_DOWNLOAD_URL), body: {
      "consumer_id": CommonUtils.consumerID.toString(),
      "category_id": Cat_Id.toString(),
      "country_index": "191",
      "program_id": programID.toString(),
      "action_event": programType.toString(),
      "software_version": CommonUtils.softwareVersion,
      "os_version": CommonUtils.osVersion,
      "phone_model": CommonUtils.deviceModel,
      'consumer_application_type': CommonUtils.consumerApplicationType,
      'consumer_language_id': CommonUtils.consumerLanguageId,
      "device_type": CommonUtils.deviceType,
      "device_token_id": CommonUtils.deviceTokenID,
      "upgrade_card": "1",
      "outlet_id": outletID,
      "join_method": "16",
      // "member_id":memberid,
    }).timeout(Duration(seconds: 30));
    debugPrint(response.body);
    if (response.statusCode == 200) {
      print(response.body);

      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var newData = data['info'];
      var status = Utils().stringSplit(newData['p1']);
var success = Utils().stringSplit2(newData['p9'])+"voucher redeemption is successful";
      var Message = Utils().stringSplit(newData['p14']);
      if (status != "False") {
        if (Platform.isAndroid) {
          showAlertDialog_oneBtnWitDismissw(context, "Alert", success);
        }
        if (Platform.isIOS) {
          var alert = ShowNativeDialogue(context, "Alert", success);
          CommonUtils.NAVIGATE_PATH = "walletPage";
          alert.whenComplete(() =>
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ConsumerTab(),)));
        }
      }
      else {
        if (Platform.isAndroid) {
          showAlertDialog_oneBtnWitDismiss(context, "Alert", Message);
        }
        if (Platform.isIOS) {
          var alert = ShowNativeDialogue(context, "Alert", Message);

          alert.whenComplete(() => Navigator.pop(context));
        }

        // ShowNativeDialogue(context,"TitleTxt", "Mesage", okbtn: () => Get() );
//ShowNativeDialogue(context, _GoBack(), "TitleTxt", "Mesage");
        // ShowNativeDialogue(context, VoidCallback, "TitleTxt", "Mesage");
        //ShowNativeDialogue(context,continueCallBack , "TitleTxt", "Mesage");
        //ShowNativeDialogue(context, _GoBack(context), "Alert", Message);
        //showAlertDialognative(context: context, title: "Alert", content: Message, cancelActionText:"null", defaultActionText: "OK");

        // final clickedButton = await FlutterPlatformAlert.showAlert(
        //
        //
        //     windowTitle:"Alert",
        //     text: Message,
        //     alertStyle:AlertButtonStyle.ok,
        //     iconStyle: IconStyle.information,
        //   );

        /* print(Message);
      }*/
      }
    }
  }

}
