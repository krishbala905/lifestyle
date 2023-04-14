import 'package:lifestyle/Others/AlertDialogUtil.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/Others/Urls.dart';
import 'package:lifestyle/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../res/Strings.dart';
class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  void initState() {
    // TODO: implement initState
    super.initState();
    hideKeyboard();
print(HISTORY_LOG_URL+"/"+CommonUtils.consumerID.toString()+"/"+"1"+"/"+CommonUtils.deviceTokenID.toString());
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      appBar: AppBar(backgroundColor: Maincolor,
        automaticallyImplyLeading: true,
        title: Text("History Log"),
        centerTitle: true,),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height ,
        child: WebView(

          gestureNavigationEnabled: true,
          initialUrl: HISTORY_LOG_URL+"/"+"1"+"/"+CommonUtils.consumerID.toString(),
          javascriptMode: JavascriptMode.unrestricted,
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            showLoadingView(context);
          },
          onPageFinished: (String url) {
            Navigator.pop(context,true);
          },

        ),
      ),
    ));}
}
