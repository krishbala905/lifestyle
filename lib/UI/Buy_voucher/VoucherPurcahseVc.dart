import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/Others/AlertDialogUtil.dart';
import 'package:lifestyle/UI/Buy_voucher/Purchase_Web_Fragment.dart';
import 'package:lifestyle/UI/Buy_voucher/VoucherPurchasemodel.dart';

import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../res/Colors.dart';
import 'package:http/http.dart' as http;

import '../../res/Strings.dart';
import '../ConsumerTab.dart';
import 'package:url_launcher/url_launcher.dart';
class VoucherpurchaseVc extends StatefulWidget {
  final PurcahsevoucherList Model;
  const VoucherpurchaseVc({Key? key,required this.Model}) : super(key: key);

  @override
  State<VoucherpurchaseVc> createState() => _VoucherpurchaseVcState(this.Model);
}

class _VoucherpurchaseVcState extends State<VoucherpurchaseVc> {
  PurcahsevoucherList Model;
  _VoucherpurchaseVcState(this.Model);
  int Numofquantity = 0;
  bool checkbox=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Your Order",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              )),

          Expanded(
              flex: 10,
              child:  ListView.builder(
                  scrollDirection: Axis.vertical,

                  itemCount:  Model.data.length,
                  physics: NeverScrollableScrollPhysics(),

                  itemBuilder: (context,intex) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                      child: Container(
                        height: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Model.data[intex].programTitle,style: TextStyle(
                              fontSize: 18
                            ),),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(

                                    child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 110,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: lightGrey1,width: 1.0)
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,

                                            children: [
                                              Container(

                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          right: BorderSide(color: lightGrey1,width: 0.5)
                                                      )
                                                  ),
                                                  width: 35,
                                                  child: TextButton(
                                                      onPressed: () async {
                                                        // _AddbtnAction(intex);
                                                        _subtractAction(intex);

                                                        // var d = int.parse(Model.data[intex].quantity);
                                                        // if(d == 1) {
                                                        //
                                                        // }
                                                        // else {
                                                        //   d -= 1;
                                                        //   setState(() {
                                                        //     Model.data[intex].quantity = d.toString();
                                                        //   });
                                                        //
                                                        //
                                                        // }
                                                        //
                                                        // print(Model.data[intex].quantity);

                                                      },
                                                      style: ButtonStyle(
                                                        foregroundColor: MaterialStateProperty.all(lightGrey1) ,
                                                      ),
                                                      child: Icon(Icons.remove,color: lightGrey1,size: 20,)
                                                  )
                                              ),
                                              SizedBox(
                                                width: 35,
                                                child: Center(


                                                  child: Text(Model.data[intex].quantity,style: TextStyle(
                                                      fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black
                                                  ),),
                                                ),
                                              ),
                                              Container(

                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          left: BorderSide(color: lightGrey1,width: 0.5)
                                                      )
                                                  ),
                                                  width: 35,
                                                  child: TextButton(
                                                    onPressed: () async {
                                                      _AddbtnAction(intex);

                                                      // var d = int.parse(Model.data[intex].quantity);
                                                      // d += 1;
                                                      // setState(() {
                                                      //   Model.data[intex].quantity = d.toString();
                                                      // });
                                                      //
                                                      // print(Model.data[intex].quantity);

                                                    },
                                                    style: ButtonStyle(
                                                      foregroundColor: MaterialStateProperty.all(lightGrey1) ,
                                                    ),
                                                    child: Icon(Icons.add,color:lightGrey1,size: 20,),
                                                  )
                                              ),



                                            ],

                                          ),
                                        ),
                                        InkWell(
                                          onTap: ()async {
                                            _DeleteVoucher(Model.data[intex].programId.toString());

                                          },

                                            child:  Image.asset("assets/delete_icon.png",width: 25,height: 25,color: Colors.grey,)),
                                      ],
                                    )
                                  ),
                                ),



                               
                                Expanded(
                                  flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          _Amount(context, Model.data[intex].indTotalAmt),

                                          // Text(Model.data[intex].indTotalAmt,style: TextStyle(
                                          //   fontSize: 18,color:Colors.black
                                          // ),),
                                          Model.data[intex].discountApplied == "yes" ?
                                              Text(  "Discount applied",style: TextStyle(
                                            color: Maincolor
                                          ),) : Container()

                                        ],
                                      ),
                                    )



                                )
                              ],
                            )
                          ],
                        )
                      ),
                    );

                  })),


          Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(left:10,right:10),
                child: Column(

                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top:15.0),
                        child: Container(
                          height: 30,

                          color: Colors.black12,
                          child: Row(

                            children: [

                              Expanded(
                                flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15,right: 15,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Total",style: TextStyle(
                                            fontSize: 15
                                        ),),
                                        _itemcount(context, Model.totalCartValue.toString())
                                      ],

                              ),
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        _totalAmount(context, Model.totalAmount)
                                      ],

                              ),
                                  ))
                              ,

                            ],
                          ),
                        ),
                      ),
                    ),


                   Padding(
                     padding: const EdgeInsets.only(top:15.0),
                     child: Container(
                       height: 40,

                       child: Row(
                         children: [
                           Checkbox(value: checkbox,
                           activeColor: corporateColor,


                           onChanged: (value){
                             setState(() {
                               checkbox=value!;
                             });

                           }),
                           Expanded(
                             child: Text.rich(


                               TextSpan(

                                 style: TextStyle(

                                     color: Colors.grey,

                                 ),


                                 text: "I agree to the Terms & Condition Click ",

                                 children: [
                                   TextSpan(text: "here" ,style: TextStyle(
                                       decoration: TextDecoration.underline
                                   ),
                                       recognizer: new TapGestureRecognizer()
                                         ..onTap = () async {
                                           String url = "http://cineleisure.com.sg/promotion/terms-conditions-sale-vouchers";
                                           var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                                           if(urllaunchable){
                                             await launch(url); //launch is from url_launcher package to launch URL
                                           }else{
                                             print("URL can't be launched.");
                                           }
                                         }
                                   ),
                                   TextSpan(text: ' for full T&C'),


                                 ],

                               ),
                               textAlign: TextAlign.left,
                             ),
                           )
                         ],
                       ),
                     ),
                   ),
                    Padding(
                      padding: const EdgeInsets.only(top:15.0),
                      child: InkWell(
                        onTap: () async {
                          if(checkbox){
                            _GoWebview();
                          }
                          else{
                            showAlertDialog_oneBtn(context, alert, "Please accept Terms & Conditions to proceed.");
                          }

                        },
                        child: Container(
                          height: 40,

                          color: Maincolor,
                          child: Center(
                            child:Text("CONFIRM PURCHASE",style: TextStyle(
                              color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold
                            ),),
                          ),

                        ),
                      ),
                    )
                  ],
                ),
              )

          )
        ],

      ),
    );
  }

_GoWebview() async {
    Iterable voucherdatas = Model.data.map((e) => e.programId + "*" + e.quantity +"*"+e.indTotalAmt);

    var prgmId="";
    var prgmQty="";
    var indAmount="";
    var totalAmount=Model.totalAmount;

    voucherdatas.forEach((element) {
      print("test12:"+element.toString());
      prgmId=prgmId+"*"+element.toString().split("*")[0];
      prgmQty=prgmQty+"*"+element.toString().split("*")[1];
      indAmount=indAmount+"*"+element.toString().split("*")[2];

    });

    print("p:"+prgmId.substring(1));
    print("q:"+prgmQty.substring(1));
    print("i:"+indAmount.substring(1));

  Navigator.push(context, MaterialPageRoute(builder:  (context)=> Purchase_web(
    prgmId.substring(1),prgmQty.substring(1),
    indAmount.substring(1),totalAmount.substring(1)
  )));



}
  _subtractAction(int index) async {
    int originalValue = int.parse(Model.data[index].programValue);
    int InitialValue = int.parse(Model.data[index].indTotalAmt);
    int quantity = int.parse(Model.data[index].quantity);
    int TotalValue = int.parse(Model.totalAmount);
    int totalquantity = int.parse(Model.totalCartValue);

    setState(() {
      if(quantity != 1 ) {
        quantity  -= 1;
        totalquantity -= 1;
        InitialValue -= originalValue;
        TotalValue -= originalValue;
      }
      // if (totalquantity != 0 ){
      //   totalquantity -= 1;
      // }



      print(TotalValue);
      Model.data[index].quantity = quantity.toString();
      Model.data[index].indTotalAmt = InitialValue.toString();

      Model.totalAmount = TotalValue.toString();
      Model.totalCartValue = totalquantity.toString();
      //print(Model.totalCartValue);

    });

  }
  _AddbtnAction(int index) async {
    int originalValue = int.parse(Model.data[index].programValue);
    int InitialValue = int.parse(Model.data[index].indTotalAmt);
    int quantity = int.parse(Model.data[index].quantity);
    int TotalValue = int.parse(Model.totalAmount);
    int totalquantity = int.parse(Model.totalCartValue);
    quantity  += 1;
    setState(() {
      totalquantity += 1;

      InitialValue += originalValue;
      TotalValue += originalValue;
      print(TotalValue);
      Model.data[index].quantity = quantity.toString();
      Model.data[index].indTotalAmt = InitialValue.toString();

      Model.totalAmount = TotalValue.toString();
      Model.totalCartValue = totalquantity.toString();
      //print(Model.totalCartValue);

    });



  }
  Widget _itemcount(BuildContext context,String count){
    return Text("($count items)");
  }
  Widget _totalAmount(BuildContext context, String str){
    var txt = str;
    return Text('\$ $txt.00',style: TextStyle(
        fontSize: 18,color:Maincolor,fontWeight: FontWeight.w400
    ),);

  }

  Widget _Amount(BuildContext context, String str){
    var txt = str;
    return Text('\$$txt.00',style: TextStyle(
          fontSize: 18,color:Colors.black
        ),);

  }
 _GetCardList() async {
    print(CommonUtils.consumerID);
    print(CHECKOUT_CARD_URL);
    final http.Response response = await http.post(Uri.parse(CHECKOUT_CARD_URL),
        body: {
          "device_type": "1",
          "consumer_id":CommonUtils.consumerID
        }
    ).timeout(Duration(seconds: 30));
    print(response.body);
    print("1111:"+json.decode(response.body)['status']);
    if(json.decode(response.body)['status']=="true"){
      setState(() {
        Model = PurcahsevoucherList.fromJson(json.decode(response.body));

      });
    }
    else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ConsumerTab(),
          ));
      CommonUtils.NAVIGATE_PATH="BUYVOUCHER";
    }







  }
  _DeleteVoucher(String Programid) async{
    print("url:"+DELETEVOUCHER_URL);

    final http.Response response = await http.post(
        Uri.parse(DELETEVOUCHER_URL),
        body: {
          "device_type":"1",
          "consumer_id":CommonUtils.consumerID.toString(),
          "program_id":Programid.toString(),
        }
    ).timeout(Duration(seconds: 30));
    print(response.body);
    var data  = jsonDecode(response.body);

    _GetCardList();


    // var mesg = data["message"];





  }
}
