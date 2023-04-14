import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifestyle/UI/Receipt/ReceiptHistory.dart';
import 'package:lifestyle/UI/Receipt/SelfHelpFragment.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../Others/CommonUtils.dart';
import '../../res/Colors.dart';
import '../../res/Strings.dart';

class ReceiptFragment extends StatefulWidget {
  const ReceiptFragment({Key? key}) : super(key: key);

  @override
  State<ReceiptFragment> createState() => _ReceiptFragmentState();
}

class _ReceiptFragmentState extends State<ReceiptFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:  Text("Receipt"),
          backgroundColor: Maincolor
      ),
     body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(

          image: DecorationImage(
            image: AssetImage('assets/receipt.png'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            InkWell(

              child: Container( height: 45,color: Maincolor,width:MediaQuery.of(context).size.width * 0.6,
                child: Center(child: Text(upload_receipt,style: TextStyle(
                    color: Whitecolor
                ),)),
              ),
              onTap: (){
                AlertDialog alert1 = AlertDialog(
                  backgroundColor: Colors.white,
                  // content: CircularProgressIndicator(),
                  content:
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(prompt_msg_for_pic,
                        textAlign:  TextAlign.center,
                        style: TextStyle(color: Colors.black45)),
                  ),


                  actions: [
                    Container(
                      decoration:BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              )
                          )
                      ) ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    )
                                  )
                                ),
                                height: 35,
                                width: 100,
                                // color: Colors.white,
                                child: Center(
                                    child: Text(
                                      cancel,
                                      style: TextStyle(color: Maincolor),
                                    )),
                              ),
                            ),
                          ),
                          /*Center(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey),
                              height: 2,
                            ),
                          ),*/
                          InkWell(
                            onTap: () async{
                              Navigator.pop(context);
                              // callNavigatepage();

                              showImgSource(context);
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 35,
                                width: 80,
                                color: Colors.white,
                                child: Center(
                                    child: Text(
                                      ok,
                                      style: TextStyle(color: Maincolor),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return alert1;
                  },
                );
               /* showDialog(

                  context: context, builder: (context) => AlertDialog(

                  content: Text(prompt_msg_for_pic),
                  actions: [
                    InkWell(
                      onTap: (){
                      Navigator.pop(context);
                      // callNavigatepage();

                          showImgSource(context);
                      },
                      child: Center(child: Text(ok,style: TextStyle(color: corporateColor,fontSize: 16),)),
                    )
                  ],
                ),);*/

              },
            ),

            SizedBox(height: 20,),

            InkWell(

              child: Container( height: 45,color: Maincolor,width:MediaQuery.of(context).size.width * 0.6,
                child: Center(child: Text(receipt_history,style: TextStyle(
                    color: Whitecolor
                ),)),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ReceiptHistory()));
              },
            ),
            SizedBox(height: 20,),
          ],

        ),
      ),
    );
  }

  Future OpenGalley(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 25);

      if (image == null) return;
      _cropImage(image, context);
    } on PlatformException catch (e) {
      print('failed : $e');
    }
  }
  Future OpenCamera(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 25);
      if (image == null) return;
      // final imagetemp = File(image.path);
      _cropImage(image, context);
    } on PlatformException catch (e) {
      print('failed : $e');
    }
  }
  Future<ImageSource?> showImgSource(BuildContext context) async {

    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(

          content:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("How would you like to submit a receipt ?",style: TextStyle(color: grey,fontSize: 15),),
              SizedBox(height: 15,),
              InkWell(

                onTap: () {
                  OpenCamera(context);
                  Navigator.of(context).pop();
                },
                child:const SizedBox(width:double.infinity,child: Text(camera,style: TextStyle(color: grey1,fontSize: 14),)),
              ),
              Container(height: 13,),
              InkWell(

                onTap: () {
                  OpenGalley(context);
                  Navigator.of(context).pop();
                },
                child:const SizedBox(width:double.infinity,child: Text(gallery,style: TextStyle(fontSize: 15,color: grey1),)),
              ),

              Container(height: 15,),
              InkWell(

                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const SizedBox(width:double.infinity,child: Text(cancel,style: const TextStyle(fontSize: 15,color: grey1),)),
              ),
            ],


          ),
        ),
      );
    }

    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(

          content:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 8,),
              const Text("How would you like to submit a receipt ?",style: TextStyle(color: grey,fontSize: 15),),
              SizedBox(height: 20,),
              InkWell(

                onTap: () {
                  OpenCamera(context);
                  Navigator.of(context).pop();
                },
                child:const SizedBox(width:double.infinity,child: Text(camera,style: TextStyle(color: grey,fontSize: 14),)),
              ),
              Container(height: 20,),
              InkWell(

                onTap: () {
                  OpenGalley(context);
                  Navigator.of(context).pop();
                },
                child:const SizedBox(width:double.infinity,child: Text(gallery,style: TextStyle(fontSize: 14,color: grey),)),
              ),

              Container(height: 20,),
              InkWell(

                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const SizedBox(width:double.infinity,child: Text(cancel,style: const TextStyle(fontSize: 14,color: grey),)),
              ),
              Container(height: 8,),
            ],


          ),
        ),
      );
    }
  }
  Future<void> _cropImage(var image, BuildContext context) async {
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 10,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: corporateColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
            const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        print("secondImage:"+CommonUtils.isSecondImagePresent.toString());
        final imagetemp = File(croppedFile.path);
        if(CommonUtils.isSecondImagePresent==0){
          CommonUtils.imageFileForReceipt = imagetemp;
          CommonUtils.imageFileName=imagetemp.path.toString();
        }
        else if(CommonUtils.isSecondImagePresent==1){
          CommonUtils.imageFileForReceipt1 = imagetemp;
          CommonUtils.imageFileName1=imagetemp.path.toString();
        }
        else{}

        print("FileName:"+imagetemp.path.toString()+":");
        try{
          if(CommonUtils.isSecondImagePresent==0){
            showConfirmationPopupforSecondImage();
          }
          else{
          print("Navigating"+":Yes Fragment");
          callNavigatepage();

          }


        }
        catch(e){print("ImageCropperException:"+e.toString());}



      }
    }
  }
  void  callNavigatepage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SelfHelpFragment(),));
  }
  showConfirmationPopupforSecondImage(){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: Text(secondImage_confirmation,style: TextStyle(fontSize: 15),),

      actions: [
        InkWell(
          onTap: (){
            CommonUtils.isSecondImagePresent=0;
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => SelfHelpFragment(),));
          },
          child: Text("NO",style: TextStyle(color: corporateColor,fontSize: 16),),
        ),
        SizedBox(width: 25,),
        InkWell(
          onTap: (){
            CommonUtils.isSecondImagePresent=1;
            Navigator.pop(context);
            showImgSource(context);
          },
          child: Text("YES",style: TextStyle(color: corporateColor,fontSize: 16),),
        ),
        SizedBox(width: 10,),
      ],
    ),);
  }
}
