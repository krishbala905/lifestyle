import 'package:lifestyle/Others/AlertDialogUtil.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/Others/Urls.dart';
import 'package:lifestyle/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../res/Strings.dart';
class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  void initState() {
    // TODO: implement initState
    super.initState();
    hideKeyboard();
print(FAQ_URL+"/"+"1"+"/"+CommonUtils.consumerID.toString()+"/"+CommonUtils.deviceTokenID.toString());
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      appBar: AppBar(backgroundColor: Maincolor,
        automaticallyImplyLeading: true,
        title: Text("FAQ"),
        centerTitle: true,),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height ,
        child: WebView(

          gestureNavigationEnabled: true,
          initialUrl: FAQ_URL,
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
