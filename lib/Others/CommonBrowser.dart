

import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../res/Colors.dart';
import 'LoadingWebPageBloc.dart';

class CommonBrowser extends StatefulWidget {
  var url,tittle;

  CommonBrowser(this.url, this.tittle,{Key? key , }) : super(key: key);
  @override
  State<CommonBrowser> createState() => _CommonBrowserState(url,tittle);

}

class _CommonBrowserState extends State<CommonBrowser> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  var tittle="";
  var url="";

  _CommonBrowserState(this.url, this.tittle);
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final LoadingWebPageBloc loadingWebPageBloc =  LoadingWebPageBloc();
    return SafeArea(child:Scaffold(
      appBar: AppBar(backgroundColor: Maincolor,
        automaticallyImplyLeading: true,
        title: Text(tittle),
        centerTitle: true,),

      body:Container(
        child: Stack(
            children:<Widget>[

              WebView(
                gestureNavigationEnabled: true,
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onProgress: (int progress) {
                  print('WebView is loading (progress : $progress%)');
                },
                onPageStarted: (String url) {
                  loadingWebPageBloc.changeLoadingWebPage(true);
                },
                onPageFinished: (String url) {
                  loadingWebPageBloc.changeLoadingWebPage(false);
                },
              ),

              StreamBuilder<bool>(
                stream: loadingWebPageBloc.loadingWebPageStream,
                initialData: true,
                builder: (context, snap) {
                  if (snap.hasData && snap.data == true) {
                    return Container(

                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SpinKitCircle(
                                  color: Maincolor,
                                  size: 50.0
                              ),
                              Text("Loading...",style: TextStyle(color: Colors.black,fontSize: 18),),

                            ],
                          ),
                        )
                    );
                  }
                  return SizedBox();
                },
              ),
            ]

        ),

      ),

    ));
  }

}