import 'package:flutter/material.dart';
import 'package:lifestyle/Others/AlertDialogUtil.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/Others/Urls.dart';
import 'package:lifestyle/UI/ConsumerTab.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InboxDetailsIOS extends StatefulWidget {
  const InboxDetailsIOS({Key? key}) : super(key: key);

  @override
  State<InboxDetailsIOS> createState() => _InboxDetailsIOSState();
}

class _InboxDetailsIOSState extends State<InboxDetailsIOS> {
var url;
  void initState() {
    // TODO: implement initState
    super.initState();
    hideKeyboard();
    DateTime time = DateTime.now ();
    print(time.toString());
    var milliseconds = time.millisecond.truncate();
    print(milliseconds.toString());
    url = INBOX_DETAILS_URL1+CommonUtils.consumerID.toString()+"/"+CommonUtils.msgid.toString()+"/"+CommonUtils.deviceType.toString()
        +"/"+CommonUtils.softwareVersion.toString()/*+"?"+milliseconds.toString()*/;

    print(url.toString());
    /*controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });*/
    /*availableCameras().then((availableCameras) {

      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          // 2
          selectedCameraIdx = 0;
        });

        *//*_initCameraController(cameras[selectedCameraIdx]).then((void v) {});*//*
      }else{
        print("No camera available");
      }
    }).catchError((err) {
      // 3
      print('Error: $err.code\nError Message: $err.message');
    });
*/
  }
  @override
  Widget build(BuildContext context) {
    /*return SafeArea(child:Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height ,
        child: InAppWebView(
          initialUrlRequest:
          URLRequest(url: Uri.parse("https://worldfarmdev.poket.com/worldfarm/PointsCma/PointsHome/")),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                mediaPlaybackRequiresUserGesture: false,
                javaScriptEnabled: true,
                supportZoom: true,
                disableContextMenu: false,
                clearCache: true,
                cacheEnabled: true,
                //  debuggingEnabled: true,
              ),

            ),
            onWebViewCreated: (InAppWebViewController controller) {
              _webViewController = controller;
            },
            androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
            var hi = PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
            print("bhar"+hi.toString());
            return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
            }
        ),
        *//*child: WebView(

          gestureNavigationEnabled: true,
          // initialUrl: "$HistoryUrl${CommonUtils.consumerID}/",
          initialUrl: "https://worldfarmdev.poket.com/worldfarm/PointsCma/PointsHome/",
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

        ),*//*
      ),
    ));*/
    return SafeArea(child:Scaffold(
      appBar: AppBar(backgroundColor: Maincolor,
        automaticallyImplyLeading: true,
        title: Text("Cathay LifeStyle"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pop(context);
            CommonUtils.NAVIGATE_PATH=CommonUtils.inboxPage;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ConsumerTab()));
            // _goBack(context);
          },
        ),),
      body: WillPopScope(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height ,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: WebView(

              gestureNavigationEnabled: true,
              initialUrl: url,
              //  initialUrl: "https://worldfarmdev.poket.com/worldfarm/PointsCma/PointsHome/",
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
        ),
        onWillPop: ()async{
          Navigator.pop(context);
          CommonUtils.NAVIGATE_PATH=CommonUtils.inboxPage;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => ConsumerTab()));
          return true;
        },
      ),
    ));
  }
}
