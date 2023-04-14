import 'package:flutter/material.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/Others/Urls.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:http/http.dart' as http;
class Historys extends StatefulWidget {
  const Historys({Key? key}) : super(key: key);

  @override
  State<Historys> createState() => _HistorysState();
}

class _HistorysState extends State<Historys> {
  final controller = WebView();
  var urlss = HISTORY_LOG_URL+"/"+"1"+"/"+CommonUtils.consumerID.toString()+"/"+CommonUtils.deviceTokenID.toString();
  void initState() {
    _getHitory();
    super.initState();

    hideKeyboard();

    /*WidgetsBinding.instance.addPostFrameCallback((_){
      // _setloadingPage();
      gethistoryurl();
    });*/

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
        appBar: AppBar(backgroundColor: Maincolor,
          automaticallyImplyLeading: true,
          title: Text("History"),
          centerTitle: true,),
        body: BuildWebview(context)
    ));
  }
  FutureBuilder<dynamic> BuildWebview( BuildContext) {
    return FutureBuilder(
        future: _getHitory(),
        builder: (context, Snapchat) {
          if(Snapchat.connectionState == ConnectionState.done ) {
            print("Enter to view");
            print(Snapchat.data);
            return WebViewPlus(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                controller.loadString(Snapchat.data.toString());
              },
            );




          }
          else {
            return Center(
              child: SpinKitCircle(color: Maincolor,),
            );
          }
        }
    );
  }
  Future<dynamic> _getHitory() async {
    var data =  await http.post(Uri.parse(HISTORY_LOG_URL),
        body: {
          "consumer_id": CommonUtils.consumerID.toString(),
          /*"action_type":"1",
          "device_token_id":CommonUtils.deviceTokenID,
          "device_type": CommonUtils.deviceType*/

        }).timeout(Duration(seconds: 30));
    print("Check"+data.body.toString());
    return data.body;

  }


}
