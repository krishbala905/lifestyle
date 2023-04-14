import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/Others/NativeAlertDialog.dart';
import 'package:lifestyle/UI/Buy_voucher/VoucherPurchaseFragment.dart';

import '../../Others/Urls.dart';
import '../../res/Colors.dart';
import 'BuyEvoucherModel.dart';
import 'package:http/http.dart' as http;

class nextbuyclass extends StatefulWidget {
  final BuyEvoucherModel Model;
  const nextbuyclass({Key? key,required this.Model}) : super(key: key);

  @override
  State<nextbuyclass> createState() => _nextbuyclassState(this.Model);
}

class _nextbuyclassState extends State<nextbuyclass> {




  BuyEvoucherModel Model;
  _nextbuyclassState(this.Model);
  String totalcartcount = "";
  bool CartcountVisibility = true;

  @override
  void initState() {
    print(Model.data.length);
    if(Model.totalCartValue.toString() == "0") {
      CartcountVisibility = false;
    }
    totalcartcount = Model.totalCartValue.toString();
   // print(Model.status.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Center(
              child:InkWell(
                onTap: (){
                 // Navigator.of(context).popUntil((route) => route.isFirst);
                  if(totalcartcount.toString()!="0"){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> VouhcerPurchaseFragment()));
                  }

                },
                child: Stack(
                  children: [
                 Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 30),
                    Visibility(
                      visible:CartcountVisibility ,
                      child: Positioned(
                        right: 0,
                        child: Container(
                          height: 20,
                          width: 20,

                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Center(
                            child: Text(totalcartcount,style: TextStyle(
                            color: Colors.white,fontSize: 10
                            ),),
                          ),
                        ),
                      ),
                    )

                  ],

                ),
              ),
            ),

            // Badge(
            //   badgeContent: Text(totalcartcount,style: TextStyle(
            //     color: Colors.white
            //   ),),
            //
            //     badgeColor: Colors.blue,
            //     child: Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 20,)),
            SizedBox(width: 20,),
          ],
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title:  Text("Buy e-vouchers"),
            backgroundColor: Maincolor
        ),
        

        body:  ListView.builder(
          itemCount: Model.data.length,
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          scrollDirection:  Axis.vertical,

          itemBuilder: ( context,  index) {
            return InkWell(
              onTap: (){

              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(

                  decoration: BoxDecoration(

                      border:Border.all(width: 0.3,color: Colors.grey)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(Model.data[index].imageUrl,fit: BoxFit.fill),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            Text("Quantity",style: TextStyle(color: Maincolor),),

                            Padding(padding: EdgeInsets.only(left: 10,right: 10),
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

                                            var d = int.parse(Model.data[index].quantity);
                                            print("bhar"+d.toString());
                                            if(d == 1||d==0) {

                                            }
                                            else {
                                              d -= 1;
                                              setState(() {
                                                Model.data[index].quantity = d.toString();
                                              });


                                            }

                                            print(Model.data[index].programTitle);

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


                                        child: Text(Model.data[index].quantity,style: TextStyle(
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

                                              var d = int.parse(Model.data[index].quantity);
                                              d += 1;
                                              setState(() {
                                                Model.data[index].quantity = d.toString();
                                              });

                                              print(Model.data[index].programTitle);

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
                            SizedBox(
                              height: 35,
                              width: 100,
                              child: Center(
                                child: TextButton(onPressed: () async {
                       AddtoCardAction(Model.data[index].quantity, Model.data[index].programId);



                                },
                                    style: ButtonStyle(

                                        backgroundColor: MaterialStateProperty.all(Maincolor)

                                    ),  child:Text("Add to Cart",style: TextStyle(
                                        color: Colors.white
                                    ),)),
                              ),
                            ),


                          ],

                        ),
                      )

                    ],

                  ),

                ),
              ),
            );
          },
        ),

      ),
    );
  }
  void AddtoCardAction(String quntity, String Programid) async{
    print("url:"+ADDTOCARD_URL);

    final http.Response response = await http.post(
        Uri.parse(ADDTOCARD_URL),
      body: {
          "device_type":"1",
          "consumer_id":CommonUtils.consumerID.toString(),
          "program_id":Programid.toString(),
          "quantity":quntity
      }
    ).timeout(Duration(seconds: 30));
    print(response.body);
    var data  = jsonDecode(response.body);
    var mesg = data["message"];

    setState(() {
      totalcartcount = data["total_cart_value"];
      CartcountVisibility=true;
    });

    ShowNativeDialogue(context, "Alert", mesg);



  }
}
// BuildVoucherList(context, snapchat.data);
