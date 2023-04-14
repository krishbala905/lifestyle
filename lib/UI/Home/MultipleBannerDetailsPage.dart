import 'dart:async';
import 'dart:convert';
import 'package:lifestyle/Others/LoadingWebPageBloc.dart';
import 'package:lifestyle/Others/Utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:http/http.dart' as http;
import 'package:lifestyle/Others/Urls.dart';
import 'package:xml2json/xml2json.dart';
import '../../res/Colors.dart';
import 'Model/MultipleBannerDetailsPageModel.dart';


class MultipleBannerDetailsPage extends StatefulWidget {
  const MultipleBannerDetailsPage({Key? key}) : super(key: key);

  @override
  State<MultipleBannerDetailsPage> createState() => _MultipleBannerDetailsPageState();
}

class _MultipleBannerDetailsPageState extends State<MultipleBannerDetailsPage> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  var image,text,url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Maincolor,
        automaticallyImplyLeading: true,
       title: Text(CommonUtils.MultipleBannerDetailPageTittle),
      ),
      body:SafeArea(
        child: getData(context),
      )
    );
  }



  Future<List<MutlipleBannerDetailsPagemodel>> getHomeBannerData() async {

    print("Id:"+CommonUtils.MultipleBannerDetailPageId.toString());

    final http.Response response = await http.post(
      Uri.parse(HOMEBANNERCMD_ITEM_DETAILS),

      body: {
        "item_id":CommonUtils.MultipleBannerDetailPageId,
        // "merchant_id": CommonUtils.merchantID.toString(),
        "consumer_id": CommonUtils.consumerID.toString(),

        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
        "device_type":CommonUtils.deviceType,
      },
    ).timeout(Duration(seconds: 30));

    debugPrint("Resp:"+await response.body.toString(),wrapWidth: 1024);
    debugPrint("RespCodae:"+response.statusCode.toString(),wrapWidth: 1024);


    if(response.statusCode==200)
    {
      final Xml2Json xml2json = new Xml2Json();
    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var data = jsonDecode(jsonstring);
    var data2 = data['info'];
    var status = Utils().stringSplit(data2['p1']);
    var p3 = Utils().stringSplit(data2['p3']);
    var p2 = Utils().stringSplit(data2['p4']);
    var p5 = Utils().stringSplit(data2['p5']);
    image = p3;
    text = p2;
    url = p5;
      List<String> Cat_Url = p5.split("*");
      List<String> Cat_Image = p3.split("*");
      List<String> Cat_Name = p2.split("*");
      List<MutlipleBannerDetailsPagemodel> object = [];
      object.add(new MutlipleBannerDetailsPagemodel(Cat_Url: Cat_Url, Cat_Image: Cat_Image, Cat_Name: Cat_Name));
      /*for (int i = 0; i < Cat_ID.length; i++) {
        object.add(new MutlipleBannerDetailsPagemodel(
            Cat_Url: Cat_Url[i], Cat_Image: Cat_Image[i], Cat_Name: Cat_Name[i]));
      }*/
      return object;
    }
    else {
      throw "Unable to retrieve posts.";
    }

  }
  FutureBuilder<List<MutlipleBannerDetailsPagemodel>> getData(BuildContext context) {

    return FutureBuilder<List<MutlipleBannerDetailsPagemodel>>(

      future: getHomeBannerData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final dynamic posts = snapshot.data;
          return _buildPosts(context, posts!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  Widget _buildPosts(BuildContext context, List<dynamic> posts) {
    final LoadingWebPageBloc loadingWebPageBloc =  LoadingWebPageBloc();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.network(image.toString()),
        Expanded(
          flex: 1,
          child: WebView(

            gestureNavigationEnabled: true,
            initialUrl: url.toString(),

            javascriptMode: JavascriptMode.unrestricted,
            // onWebViewCreated: (WebViewController webViewController) {
            //   _controller.complete(webViewController);
            // },
            // onProgress: (int progress) {
            //   print('WebView is loading (progress : $progress%)');
            // },
            // onPageStarted: (String url) {
            //   loadingWebPageBloc.changeLoadingWebPage(true);
            // },
            // onPageFinished: (String url) {
            //   loadingWebPageBloc.changeLoadingWebPage(false);
            // },
          ),
        ),
      ],
    );
  }
}
