import 'dart:convert';
import 'dart:ffi';

import 'package:lifestyle/Others/CommonUtils.dart';
//import 'package:lifestyle/UI/Reward/RewardsPageModdel/RewardsListModel.dart';
// import 'package:lifestyle/UI/Wallet/WalletDetailFragment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifestyle/Others/Urls.dart';
import 'package:lifestyle/Others/Utils.dart';
import 'package:lifestyle/UI/Wallet/WalletDetailFragment.dart';
import 'package:lifestyle/res/Strings.dart';
import 'package:xml2json/xml2json.dart';
import 'package:lifestyle/UI/Wallet/Wallet_Model.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../res/Colors.dart';
import 'WalletThirdScreen.dart';
import 'WalletViewmodel.dart';

class WalletFragment extends StatefulWidget {
  const WalletFragment({Key? key}) : super(key: key);

  @override
  State<WalletFragment> createState() => _WalletFragmentState();
}

class _WalletFragmentState extends State<WalletFragment> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _GetLiastData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(


        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:  Text("Wallet"),
    backgroundColor: Maincolor
    ),
    body:_LoadWalletBuilder(context));
  }

  Future<List<WalletViewmodel>> _GetLiastData() async{
    print("check"+ CommonUtils.consumerID.toString());
    print(WALLETPAGE_URL);
    final http.Response response = await http.post(
        Uri.parse(WALLETPAGE_URL),
        body: {
          "consumer_id": CommonUtils.consumerID.toString(),
          "action":"77",
          "device_token_id":CommonUtils.deviceTokenID.toString(),
        }
    ).timeout(Duration(seconds: 30));
    print("check1"+ response.body.toString());
    if (response.statusCode == 200) {
      debugPrint("Wallet1:" + response.body);
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var newData = data['info'];
      var p1 = Utils().stringSplit(newData['p1']);

      var p2 = Utils().stringSplit(newData['p2']);

      var p3 = Utils().stringSplit(newData['p3']);
      var p4 = Utils().stringSplit(newData['p4']);
      var p5 = Utils().stringSplit(newData['p5']);
      var p6 = Utils().stringSplit(newData['p6']);
      var p7 = Utils().stringSplit(newData['p7']);
      List<String> programID = p1.split("*");
      List<String> merchantID = p2.split("*");
      List<String> voucherNo = p3.split("*");
      List<String> giftVoucherStripes = p4.split("*");
      List<String> databaseID = p5.split("*");
      List<String> countryIndex = p6.split("*");
      List<String> programType = p7.split("*");
      List<Walletmodel> object = [];
      List<WalletViewmodel> object1 = [];

      for (int i = 0; i < programID.length; i++) {
        object.add(new Walletmodel(
            programID: programID[i],
            merchantID: merchantID[i],
            voucherNo: voucherNo[i],
            giftVoucherStripes: giftVoucherStripes[i],
            databaseID: databaseID[i],
            countryIndex: countryIndex[i],
            programType: programType[i]
        ));
      }

    //  print(programID[0].toString());
     // print(programID.length);
      for (int i = 0; i < programID.length; i++) {
        var programid = programID[i].toString();
        var programtype = programType[i].toString();
        var merchantid = merchantID[i].toString();
        var voucherno = voucherNo[i].toString();
        var databaseid = databaseID[i].toString();
        var giftvoucherstripe = giftVoucherStripes[i].toString();
        final http.Response res = await http.post(
            Uri.parse(WALLETPAGE_URL),
            body: {
              "consumer_id": CommonUtils.consumerID.toString(),
              "action": "88",
              "device_token_id": CommonUtils.deviceTokenID.toString(),
              "program_type": programtype,
              "program_id": programid,
              "merchant_id": merchantid,
              "voucher_no": voucherno,
              "database_id": databaseid
            }
        ).timeout(Duration(seconds: 30));
        debugPrint("check1" + res.body.toString());
        if(res.statusCode == 200){
          final Xml2Json xml2json = new Xml2Json();
          xml2json.parse(res.body);
          var jsonstring = xml2json.toParker();
          var data = jsonDecode(jsonstring);
          var newdata = data['info'];

          debugPrint("bharathi"+newdata.toString());
          if(programtype == "rs"|| programtype == "rm"){
          //  print("hii");
            var newData = newdata['info'];
           var p1 = Utils().stringSplit(newData['p1']);
           // print("hii"+ p1.toString());
            var p2 = Utils().stringSplit(newData['p2']);

            var p3 = Utils().stringSplit(newData['p3']);
            var p4 = Utils().stringSplit(newData['p4']);
            var p5 = Utils().stringSplit(newData['p5']);
            var p6 = Utils().stringSplit(newData['p6']);
            var p7 = Utils().stringSplit(newData['p7']);
            var p8 = Utils().stringSplit(newData['p8']);
            var p9 = Utils().stringSplit(newData['p9']);
            var p10 = Utils().stringSplit(newData['p10']);
            var p11= Utils().stringSplit(newData['p11']);
            var p12= Utils().stringSplit(newData['p12']);
            var p13= Utils().stringSplit(newData['p13']);
            var p14= Utils().stringSplit(newData['p14']);
            var p15= Utils().stringSplit(newData['p15']);
            var p16= Utils().stringSplit(newData['p16']);
            var p17= Utils().stringSplit(newData['p17']);
            var p18= Utils().stringSplit(newData['p18']);
            var p19= Utils().stringSplit(newData['p19']);
            var p20= Utils().stringSplit(newData['p20']);
            var p21= Utils().stringSplit(newData['p21']);
            var p22= Utils().stringSplit(newData['p22']);
            var p23= Utils().stringSplit(newData['p23']);
            var p24= Utils().stringSplit(newData['p24']);
            var p25= Utils().stringSplit(newData['p25']);
            // print(p1+p2+p3+p4+p5+p6+"end"+p25+p24);
            String merchantName = p2.split("*")[0].toString();
            String merchantID = p2.split("*")[1].toString();
            String merchantEmail = p2.split("*")[2].toString();
            String merchantWebsite = p2.split("*")[3].toString();

            String merchantLogoURL = p3.split("*")[0].toString();
            String displayLogoFlag = p3.split("*")[1].toString();

            String merchantCategory = p4.split("*")[0].toString();
            String merchantSubCategory = p4.split("*")[1].toString();

            String programBackgroundImgURL = p5.split("*")[0].toString();

            String programTextColor = p6.split("*")[0].toString();
            String programID = p7.split("*")[0].toString();
            String countryIndex = p7.split("*")[1].toString();
            String sroSettings = p7.split("*")[2].toString();
            String programExpiryDate = p8.split("*")[0].toString();
            String programTitle = p9.split("*")[0].toString().replaceAll("%24", "\$");
            String displayTitleFlag =p9.split("*")[1].toString();
            String programCategory = (p10.split("*")[0].toString()).split(":")[0].toString();
            String programPoints = (p10.split("*")[0].toString()).split(":")[1].toString();
            String upgradeRequirement = p11.split("*")[0].toString();

            String tnc = p12.split("*")[0].toString();
            String benefits = p13.split("*")[0].toString();
            List outletList =[];
            outletList = p18.split("*") as List;
          //  print("check10"+ outletList.toString());
           // print("check10"+ outletList.length.toString());
            List outletName= [];
            List outletIDList = [] ;
            if (outletList.length!=0) {
             // print("hii");
              for (int i = 0; i < outletList.length; i++) {
                List arrayDetailList = (outletList[i]).split(":");
               // print(arrayDetailList.toString());
                outletName.add(arrayDetailList[0]);
                outletIDList.add(arrayDetailList[1]);
                /*outletIDList = arrayDetailList[1].toString() as List;
                outletName = arrayDetailList[0].toString() as List;*/
             //   print("Check11"+outletName.toString());
               // print("Check12"+outletIDList.toString());
              }
            }
            //print("Check11"+outletName[0].toString());
           // print("Check12"+outletIDList[1].toString());
            List outletContact = p20.split("*") as List;
            List outletAddress = p21.split("*") as List;
            List outletBuiding = p22.split("*") as List;
            List outletOpHours = p23.split("*") as List;
           // List bundleFormat = p25.split("*") as List;
            String memberID = p24.split("*")[0].toString();
           // print(outletAddress.toString());
           //  List<WalletViewmodel> object1 = [];
              object1.add(new WalletViewmodel(
                  programBackgroundImgURL: programBackgroundImgURL,
                  programTitle:programTitle,
                  programExpiryDate:programExpiryDate,
                tnc: tnc,benefits:benefits,programID:programID,
                  countryIndex:countryIndex,merchantName:merchantName,
                merchantID:merchantID,
                merchantEmail:merchantEmail,
                merchantWebsite: merchantWebsite,
                merchantLogoURL:merchantLogoURL,
                displayLogoFlag:displayLogoFlag,
                merchantCategory:merchantCategory,
                merchantSubCategory:merchantSubCategory,
                programTextColor:programTextColor,
                sroSettings:sroSettings,
                displayTitleFlag:displayTitleFlag,
                programCategory: programCategory,
                programPoints:programPoints,
                upgradeRequirement:upgradeRequirement,
                outletName:outletName,
                outletIDList:outletIDList,
                outletContact:outletContact,
                outletAddress:outletAddress,
                outletBuiding:outletBuiding,
                outletOpHours:outletOpHours,
              //  bundleFormat:bundleFormat,
                memberID:memberID,
                  serialnumber:"",outletList: outletList,giftvoucherstripe:giftvoucherstripe,programtype:programtype

              ));
           // print("test1"+ object1.length.toString());


          }
          else if (programtype =="rv"){
          //  print("hiii");
            // var newData = newdata['info'];
            var p1 = Utils().stringSplit(newdata['p1']);
         //   print("hiii"+ p1.toString());
            var p2 = Utils().stringSplit(newdata['p2']);

            var p3 = Utils().stringSplit(newdata['p3']);
            var p4 = Utils().stringSplit(newdata['p4']);
            var p5 = Utils().stringSplit(newdata['p5']);
            var p6 = Utils().stringSplit(newdata['p6']);
            var p7 = Utils().stringSplit(newdata['p7']);
            var p8 = Utils().stringSplit(newdata['p8']);
            var p9 = Utils().stringSplit(newdata['p9']);
            var p10 = Utils().stringSplit(newdata['p10']);
            var p11= Utils().stringSplit(newdata['p11']);
            var p12= Utils().stringSplit(newdata['p12']);
            var p13= Utils().stringSplit(newdata['p13']);
            var p14= Utils().stringSplit(newdata['p14']);
            var p15= Utils().stringSplit(newdata['p15']);
            var p16= Utils().stringSplit(newdata['p16']);
            var p17= Utils().stringSplit(newdata['p17']);
            var p18= Utils().stringSplit(newdata['p18']);
            var p19= Utils().stringSplit(newdata['p19']);
            var p20= Utils().stringSplit(newdata['p20']);
            var p21= Utils().stringSplit(newdata['p21']);
            var p22= Utils().stringSplit(newdata['p22']);
            var p23= Utils().stringSplit(newdata['p23']);
            String merchantName = p2.split("*")[0].toString();
            String merchantID = p2.split("*")[1].toString();
            String merchantEmail = p2.split("*")[2].toString();
            String merchantWebsite = p2.split("*")[3].toString();

            String merchantLogoURL = p3.split("*")[0].toString();
            String displayLogoFlag = p3.split("*")[1].toString();

            String merchantCategory = p4.split("*")[0].toString();
            String merchantSubCategory = p4.split("*")[1].toString();

            String programBackgroundImgURL = p5.split("*")[0].toString();

            String programTextColor = p6.split("*")[0].toString();
            String programID = p7.split("*")[0].toString();
            String countryIndex = p7.split("*")[1].toString();
            String sroSettings = p7.split("*")[2].toString();
            String programExpiryDate = p8.split("*")[0].toString();
            String programTitle = p9.split("*")[0].toString().replaceAll("%24", "\$");
            String displayTitleFlag =p9.split("*")[1].toString();
            String programCategory = (p10.split("*")[0].toString()).split(":")[0].toString();
            String programPoints = (p10.split("*")[0].toString()).split(":")[1].toString();
            // String upgradeRequirement = p11.split("*")[0].toString();

            String tnc = p11.split("*")[0].toString();
            String benefits = p12.split("*")[0].toString();
            String voucherDescription = p13.split("*")[0].toString();
            String promptMessage = p14.split("*")[0].toString();
            List outletList =[];
            outletList = p15.split("*") as List;
          //  print("check10"+ outletList.toString());
          //  print("check10"+ outletList.length.toString());
            List outletName= [];
            List outletIDList = [] ;
            if (outletList.length!=0) {
             // print("hii");
              for (int i = 0; i < outletList.length; i++) {
                List arrayDetailList = (outletList[i]).split(":") as List;
               // print(arrayDetailList.toString());
                outletName.add(arrayDetailList[0]);
                outletIDList.add(arrayDetailList[1]);
                /*outletIDList = arrayDetailList[1].toString() as List;
                outletName = arrayDetailList[0].toString() as List;*/
              //  print("Check11"+outletName.toString());
              //  print("Check12"+outletIDList.toString());
              }
            }
           // print("Check15"+outletName[0].toString());
           // print("Check16"+outletIDList[1].toString());
            List outletContact = p17.split("*") as List;
            List outletAddress = p18.split("*") as List;
            List outletBuiding = p19.split("*") as List;
            List outletOpHours = p20.split("*") as List;
            //List bundleFormat = p22.split("*") as List;
            String serialnumber = p21.split("*")[0].toString();
            // List<WalletViewmodel> object1 = [];
            object1.add(new WalletViewmodel(
              programBackgroundImgURL: programBackgroundImgURL,
              programTitle:programTitle,
              programExpiryDate:programExpiryDate,
              tnc: tnc,benefits:benefits,programID:programID,
              countryIndex:countryIndex,merchantName:merchantName,
              merchantID:merchantID,
              merchantEmail:merchantEmail,
              merchantWebsite: merchantWebsite,
              merchantLogoURL:merchantLogoURL,
              displayLogoFlag:displayLogoFlag,
              merchantCategory:merchantCategory,
              merchantSubCategory:merchantSubCategory,
              programTextColor:programTextColor,
              sroSettings:sroSettings,
              displayTitleFlag:displayTitleFlag,
              programCategory: programCategory,
              programPoints:programPoints,
              upgradeRequirement:"",
              outletName:outletName,
              outletIDList:outletIDList,
              outletContact:outletContact,
              outletAddress:outletAddress,
              outletBuiding:outletBuiding,
              outletOpHours:outletOpHours,
             // bundleFormat:bundleFormat,
              memberID:"",
                serialnumber:serialnumber, outletList: outletList,programtype:programtype,giftvoucherstripe: giftvoucherstripe

            ));
          //  print("test"+ object1.length.toString());

          }else{

          }
        }
      }
      print("newdata1"+ object1.length.toString());
      return object1;
    }
    else {
      throw "Unable to retrieve posts.";
    }

  }

  FutureBuilder<List<WalletViewmodel>> _LoadWalletBuilder(BuildContext context){

    return FutureBuilder<List<WalletViewmodel>>(
        future: _GetLiastData(),
        builder: (context,Snapchat) {
          if(Snapchat.connectionState == ConnectionState.done) {
            final List<WalletViewmodel>? post = Snapchat.data;
            if(post!=null && post.isNotEmpty) {
              return LoadList(context, post);
            }
            else{

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Center(child: Text(no_card_found,style: TextStyle(color: corporateColor,fontSize: 15),)),
                    ],
              );
            }
          }
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        }
    );
  }
  Widget LoadList(BuildContext context, List<WalletViewmodel> Post) {
print("newdata"+ Post.length.toString());
    return AnimationLimiter(

        child:
        GridView.builder(
            itemCount: Post.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 250,

                crossAxisCount: 2

            ), itemBuilder: (context, index) {
          return
            AnimationConfiguration.staggeredList(position: index,
              duration: const Duration(milliseconds: 375),

              child:
              SlideAnimation(
                verticalOffset: 50.0,

                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    child: InkWell(
                      onTap: (){
                       // print(index);
                        if(Post[index].giftvoucherstripe =="0") {
                          /*Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  WalletSecondScreen(object1: Post[index])));*/

                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  WalletThirdScreen(object1: Post[index])));
                        }
                        else{

                        }

                      },
                      child: Container(
                        height: 500,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Colors.black26)

                        ),
                        child: Column(

                          children: [
                            Post[index].giftvoucherstripe=="0"?
                            /*InkWell(
                              onTap: ()async{
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WalletSecondScreen(object1: Post[index])));
                              },*/
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 15.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                      height:125,
                                      child: Image.network(Post[index].programBackgroundImgURL,fit: BoxFit.fill,)),
                                ),
                              )
                           // )
                                :
                                Padding(padding:const EdgeInsets.only(left: 10.0,right: 10.0,top: 15.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Container(
                                        height:125,
                                        //color: Colors.blue,
                                        child: Stack(
                                          fit: StackFit.expand,
                                        //  fit: StackFit.loose,
                                          children:[
                                           // AspectRatio(aspectRatio: 5,fit,child: Image.network(Post[index].programBackgroundImgURL, fit: BoxFit.fill,),),
                                           Image.network(Post[index].programBackgroundImgURL, fit: BoxFit.fill,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                //SizedBox(width: 20,),
                                                Stack(
                                                  children:[
                                                     Center(
                                                        child: Image.asset("assets/icon_gifted.png",width: 120)
                                                    ),
                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          SizedBox(height: 40,),
                                                          Center(
                                                            child: Text("Gifted to Friend",style: TextStyle(color: Maincolor),),
                                                          )
                                                        ]),
                                            ]

                                                ),
                                              ],
                                            ),

                                          ],
                                        ),

                                    ),
                                  ),
                                ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(Post[index].programTitle,style: TextStyle(
                                fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Expiry: "+Post[index].programExpiryDate,style: TextStyle(
                              fontSize: 13,
                            ),),



                          ],
                        ),

                      ),



                    ),
                  ),
                ),
              )

          );

        }

        )

    );


  }
}
