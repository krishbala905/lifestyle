import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CommonUtils.dart';
class Utils {
  Future<void> call(mobile) async {

    final Uri launchUri=Uri(
      scheme: 'tel',
      path: mobile,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $mobile';
    }
  }

  Future<void> getDeviceINFO() async {
    var deviceData = <String, dynamic>{};
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        CommonUtils.deviceType="2";
        deviceData =
            _readAndroidBuildData(await deviceInfoPlugin.androidInfo);

        CommonUtils.osVersion='${deviceData['version.sdkInt']}';
        CommonUtils.manufacturer='${deviceData['manufacturer']}';
        CommonUtils.deviceModel='${deviceData['brand']}${deviceData['device']}';

        if(CommonUtils.deviceModel.toString().toLowerCase().startsWith("huawei")){
          CommonUtils.new_huwavei_device=1;

        }
        else{
          CommonUtils.new_huwavei_device=0;
        }

      }
      else if (Platform.isIOS) {
        //   CommonUtils.deviceType="1";
        //   deviceData = _readIosDeviceInfo(await deviceInfoPlugin.o);
        // //  deviceData['version.systemVersion'];
        //   CommonUtils.osVersion= "15.5";
        //   CommonUtils.deviceModel=deviceData['model'];

        var iosInfo = await DeviceInfoPlugin().iosInfo;
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        var version = iosInfo.systemVersion;
        CommonUtils.deviceType="2";
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        CommonUtils.osVersion = version;
        CommonUtils.deviceModel= iosInfo.model;
       // CommonUtils.softwareVersion ='2.0.9';

        CommonUtils.softwareVersion = packageInfo.version;
      }
      else {

      }


    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
  }

  //
  // Future<String> Base64Decodernew( String Text) async {
  //   final base64Decoder = base64.decoder;
  //   var base64Bytes = Text;
  //   final decodedBytes = base64Decoder.convert(base64Bytes);
  //      String data =  utf8.decode(decodedBytes);
  //      print(data);
  //
  //
  //
  //   return data;
  //
  // }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  String getTimeStamp(){
    DateTime _now = DateTime.now();
    CommonUtils.timeStamp='${_now.hour}:${_now.minute}:${_now.second}.${_now.millisecond}';
    return CommonUtils.timeStamp.toString();
  }

  String getTimeZone(){
    DateTime now = DateTime.now();
    var timezone = now.timeZoneName;
    var offset = now.timeZoneOffset;
    CommonUtils.timeZone='timeZone: ${timezone}:${offset}';
    return CommonUtils.timeZone.toString();
  }


/*Future<bool> getInternetConnectionStatus()async{
    bool result = await InternetConnectionChecker().hasConnection;

    return result;
  }*/
  String stringSplit(String data) {
    return data.split("*%8%*")[0];
  }
  String stringSplit1(String data) {
    return data.split(",:0*%8%*")[0];
  }
  String stringSplit2(String data) {
    return data.split("*0*%8%*")[0];
  }

  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return true;
    } else {
      return false;
    }
  }
}