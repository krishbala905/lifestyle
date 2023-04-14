
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/UI/Buy_voucher/Buy_VoucherFragment.dart';
import 'package:lifestyle/UI/Buy_voucher/VoucherPurcahseVc.dart';
import 'package:lifestyle/UI/Buy_voucher/VoucherPurchasemodel.dart';
import 'package:lifestyle/UI/ConsumerTab.dart';

import '../../Others/Urls.dart';
import '../../res/Colors.dart';

class VouhcerPurchaseFragment extends StatefulWidget {
  const VouhcerPurchaseFragment({Key? key}) : super(key: key);

  @override
  State<VouhcerPurchaseFragment> createState() => _VouhcerPurchaseFragmentState();
}

class _VouhcerPurchaseFragmentState extends State<VouhcerPurchaseFragment> {
  @override
  void initState() {
    //GetCardList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () async {
               // Navigator.of(context).popUntil(ModalRoute.withName("/Buy_VoucherFragment"));
                 // Navigator.popUntil(context, ModalRoute.withName('/Buy_VoucherFragment'));
                CommonUtils.NAVIGATE_PATH = CommonUtils.buyVoucherPage;
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>ConsumerTab(),), (route) => route.isFirst);

               // Navigator.of(context).popUntil((route) => route.isFirst);
                //Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),

            elevation: 0,
            //automaticallyImplyLeading: false,
            centerTitle: true,
            title:  Text("Evoucher Purchase"),
            backgroundColor: Maincolor
        ),
        body: LoadData(context)
      )
    );
  }
  FutureBuilder LoadData(BuildContext context) {

    return FutureBuilder(
        future: GetCardList(),
        builder: (context,snapchat) {

      if(snapchat.connectionState == ConnectionState.done) {
        PurcahsevoucherList model = snapchat.data;

        return VoucherpurchaseVc(Model: model);
      }
      else {
        return Container();
      }

    });
  }

   Future<PurcahsevoucherList> GetCardList() async {
    print(CommonUtils.consumerID);
    print(CHECKOUT_CARD_URL);
    final http.Response response = await http.post(Uri.parse(CHECKOUT_CARD_URL),
        body: {
          "device_type": "1",
          "consumer_id":CommonUtils.consumerID
        }
    ).timeout(Duration(seconds: 30));
    print(response.body);

    PurcahsevoucherList res = PurcahsevoucherList.fromJson(json.decode(response.body));
    print("hello");
    print(res.status);

return res;

  }

  Widget _LoadCardList(BuildContext context,PurcahsevoucherList Model) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

          Expanded(
              flex: 1,
             child: Padding(
               padding: const EdgeInsets.all(10.0),
               child: Text("your Order",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
             )),
          Expanded(
            flex: 10,
              child:  ListView.builder(
            scrollDirection: Axis.vertical,

            itemCount:  Model.data.length,
              physics: NeverScrollableScrollPhysics(),

              itemBuilder: (context,intex) {
            return Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 20),
              child: Container(
                height: 50,
                child: Padding(padding: EdgeInsets.only(left: 10,right: 10),
                  child: Container(
                    width: 110,
                    height: 35,
                    decoration: BoxDecoration(
                        border: Border.all(color: Maincolor,width: 1.0)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Container(

                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(color: Maincolor,width: 0.5)
                                )
                            ),
                            width: 35,
                            child: TextButton(
                                onPressed: () async {


                                  var d = int.parse(Model.data[intex].quantity);
                                  if(d == 1) {

                                  }
                                  else {
                                    d -= 1;
                                    setState(() {
                                      Model.data[intex].quantity = d.toString();
                                    });


                                  }

                                  print(Model.data[intex].quantity);

                                },
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(Maincolor) ,
                                ),
                                child: Icon(Icons.remove,color: Maincolor,size: 20,)
                            )
                        ),
                        SizedBox(
                          width: 35,
                          child: Center(


                            child: Text(Model.data[intex].quantity,style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 15,color: Maincolor
                            ),),
                          ),
                        ),
                        Container(

                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(color: Maincolor,width: 0.5)
                                )
                            ),
                            width: 35,
                            child: TextButton(
                              onPressed: () async {

                                var d = int.parse(Model.data[intex].quantity);
                                d += 1;
                                setState(() {
                                  Model.data[intex].quantity= d.toString();
                                });

                                print(Model.data[intex].quantity);

                              },
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(Maincolor) ,
                              ),
                              child: Icon(Icons.add,color:Maincolor,size: 20,),
                            )
                        ),



                      ],

                    ),
                  ),


                ),
                ),
            );

          })),


          Expanded(
              flex: 4,
              child: Center(child: Text("your Order")))
      ],

    );
    // return ListView.builder(
    //   scrollDirection: Axis.vertical,
    //
    //   itemCount:  Model.data.length,
    //     physics: NeverScrollableScrollPhysics(),
    //
    //     itemBuilder: (context,item) {
    //   return Container(
    //     height: 50,
    //     color: Colors.red,);
    //
    // });
  }
}
