import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lifestyle/Others/AlertDialogUtil.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/UI/ConsumerTab.dart';
import '../../Others/Urls.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../res/Colors.dart';

class Purchase_web extends StatefulWidget {

  String prgmId="",prgmQTY="",indvAmnt="",totalAmount="";


  Purchase_web(this.prgmId, this.prgmQTY, this.indvAmnt, this.totalAmount);

  @override
  State<Purchase_web> createState() => _Purchase_webState(prgmId,prgmQTY,indvAmnt,totalAmount);
}

class _Purchase_webState extends State<Purchase_web> {
  String url_encode="";
  String prgmId="",prgmQTY="",indvAmnt="",totalAmount="";


  _Purchase_webState(
      this.prgmId, this.prgmQTY, this.indvAmnt, this.totalAmount);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    url_encode="action_type=1&consumer_id="+CommonUtils.consumerID.toString()+
        "&program_id="+prgmId+"&program_quantity="+prgmQTY+"&individual_amount="+indvAmnt+"&total_amount="+totalAmount;
    print("PayURL"+url_encode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:  Text("Confirm Payment"),
          backgroundColor: Maincolor

      ),
      body: Container(
        width: double.infinity,
        height:500 ,
        child: InAppWebView(

          initialUrlRequest: URLRequest(
            url: Uri.parse(PAYMENT_URL),
            method: 'POST',
            body: Uint8List.fromList(utf8.encode(url_encode)),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
            },

          ),
          onWebViewCreated: (controller) {
          },
          onProgressChanged: (InAppWebViewController controller,int progres){
          },

          onTitleChanged: (controller, title) {

            if(title.toString()=="returntocma"){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ConsumerTab(),));
                CommonUtils.NAVIGATE_PATH="walletPage";
            }

          },
        ),
        ),

    );
  }
}
