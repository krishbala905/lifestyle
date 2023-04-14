import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/UI/Buy_voucher/NextBuyVc.dart';
import 'package:lifestyle/res/Colors.dart';

import '../../Others/Urls.dart';
import 'package:lifestyle/UI/Buy_voucher/BuyEvoucherModel.dart';

import '../../res/Strings.dart';

class Buy_VoucherFragment extends StatefulWidget {
  const Buy_VoucherFragment({Key? key}) : super(key: key);

  @override
  State<Buy_VoucherFragment> createState() => _Buy_VoucherFragmentState();
}

class _Buy_VoucherFragmentState extends State<Buy_VoucherFragment> {
  var count = 1;
  TextEditingController quantity = TextEditingController();
  @override
  void initState() {
    count += 1;
    print(CommonUtils.consumerID);
   // GetEvoucherList();
    super.initState();
  }
  Future<int> incre(int num) async {

    return num += 1;


  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
        top: false,
        child: Scaffold(
            /*appBar: AppBar(backgroundColor: Maincolor,
              automaticallyImplyLeading: true,
              elevation: 1,
              title: Text(login_small_letter,style: TextStyle(color: Whitecolor),),
              centerTitle: true,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                color: Colors.white,
                icon:Icon(Icons.arrow_back),
                //replace with our own icon data.
              ),),*/
           body: LoadBuyEvoucher(context))
    );
  }

  FutureBuilder LoadBuyEvoucher(BuildContext  ) {

    return FutureBuilder(
      future: GetEvoucherList(),

        builder: (context,snapchat) {
        if(snapchat.connectionState == ConnectionState.done) {
          BuyEvoucherModel? model = snapchat.data;
         //print("check"+ model.data.length.toString());
          if(model!=null && model.data.isNotEmpty){
            return nextbuyclass(Model: model);
          }
         else{
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                 children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Container(
                        decoration: BoxDecoration(color: Maincolor),
                        height: 80,
                        width: double.infinity,
                       child: Padding(
                         padding: const EdgeInsets.only(top: 14),
                         child: Center(
                           child: Text("Buy e-vouchers",

                               style:TextStyle(

                             fontSize: 20,
                             color: Colors.white,
                           )),
                         ),
                       ),
                      ),
                      /*Positioned(
                        top :MediaQuery.of(context).size.height * 0.4,
                        child:
                      Center(child: Text("hii")),
                      ),*/
                      /*Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Center(child: Text("hii")),
                        ),
                      ),*/
                    ]
                  ),
                   Positioned(
                     top: MediaQuery.of(context).size.height * 0.5,
                       left: 10,
                       right: 10,
                       child: Center(child: Text("No Vouchers Found")))
                ],
              )
            );
            /*Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Center(child: Text("No Data Available/Make sure to turn On Internet connection",style: TextStyle(color: corporateColor,fontSize: 15),)),
                ],
              ),
            );*/
          }

        }
        else {
          return Center(
            child: CircularProgressIndicator(
              color: Maincolor,
            ),
          );
        }
    },
    );

  }

 /*BuildVoucherList(BuildContext context, BuyEvoucherModel Model ) {



  return ListView.builder(
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
                                        print("bara"+d.toString());
                                        if(d == 1) {

                                        }
                                        else {
                                          d -= 1;
                                          setState(() {
                                            Model.data[index].quantity = d.toString();
                                          });


                                        }

                                        print("check"+Model.data[index].programTitle);

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
                          child: TextButton(onPressed: (){

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
  );

}*/
  // return AnimationLimiter(
  // child: ListView.builder(
  // itemCount: Model.data.length,
  // itemBuilder: ( context,  index) {
  // return AnimationConfiguration.staggeredList(
  // position: index,
  // duration: const Duration(milliseconds: 375),
  // child: SlideAnimation(
  // verticalOffset: 50.0,
  // child: FadeInAnimation(
  // child: InkWell(
  // onTap: (){
  //
  // },
  // child: Padding(
  // padding: const EdgeInsets.all(5),
  // child: Container(
  //
  // decoration: BoxDecoration(
  //
  // border:Border.all(width: 0.3,color: Colors.grey)
  // ),
  // child: Column(
  // crossAxisAlignment: CrossAxisAlignment.start,
  // children: [
  // Image.network(Model.data[index].imageUrl,fit: BoxFit.fill),
  // SizedBox(
  // height: 50,
  // child: Row(
  // mainAxisAlignment: MainAxisAlignment.end,
  //
  // children: [
  // Text("Quantity",style: TextStyle(color: Maincolor),),
  //
  // Padding(padding: EdgeInsets.only(left: 10,right: 10),
  // child: Container(
  // width: 110,
  // height: 35,
  // decoration: BoxDecoration(
  // border: Border.all(color: Maincolor,width: 1.0)
  // ),
  // child: Row(
  // crossAxisAlignment: CrossAxisAlignment.center,
  //
  // children: [
  // Container(
  //
  // decoration: BoxDecoration(
  // border: Border(
  // right: BorderSide(color: Maincolor,width: 0.5)
  // )
  // ),
  // width: 35,
  // child: TextButton(
  // onPressed: (){
  // print(Model.data[index].programTitle);
  //
  // },
  // style: ButtonStyle(
  // foregroundColor: MaterialStateProperty.all(Maincolor) ,
  // ),
  // child: Text("-"),
  // )
  // ),
  // SizedBox(
  // width: 35,
  // child: Center(
  // child: Text(Model.data[index].quantity,style: TextStyle(
  // fontWeight: FontWeight.bold,fontSize: 15,color: Maincolor
  // ),),
  // ),
  // ),
  // Container(
  // decoration: BoxDecoration(
  // border: Border(
  // left: BorderSide(color: Maincolor,width: 0.5)
  // )
  // ),
  // width: 35,
  // child: TextButton(
  // onPressed: (){
  // PlusAction(Model,index);
  // // arr.elementAt(index) = "2";
  //
  //
  // },
  // style: ButtonStyle(
  // foregroundColor: MaterialStateProperty.all(Maincolor) ,
  //
  // ),
  // child: Text("+"),
  // )
  // ),
  // ],
  //
  // ),
  // ),
  //
  //
  // ),
  // SizedBox(
  // height: 35,
  // width: 100,
  // child: Center(
  // child: TextButton(onPressed: (){
  //
  // },
  // style: ButtonStyle(
  //
  // backgroundColor: MaterialStateProperty.all(Maincolor)
  //
  // ),  child:Text("Add to Cart",style: TextStyle(
  // color: Colors.white
  // ),)),
  // ),
  // ),
  //
  //
  // ],
  //
  // ),
  // )
  //
  // ],
  //
  // ),
  //
  // ),
  // ),
  // )
  //
  // ),
  // ),
  // );
  // },
  // ),
  // );
Future<void> PlusAction( BuyEvoucherModel Onemodel,int index ) async{
    setState(() {
      Onemodel.data[index].quantity = "2";
    });




}
  Future<BuyEvoucherModel> GetEvoucherList() async {
    print(CommonUtils.consumerID);
    print(BUYEVOUCHER_URL);
    final http.Response response = await http.post(Uri.parse(BUYEVOUCHER_URL),
      body: {
        "device_type": "1",
        "consumer_id":CommonUtils.consumerID
      }
    ).timeout(Duration(seconds: 30));
    print(response.body);

    BuyEvoucherModel res = BuyEvoucherModel.fromJson(json.decode(response.body));
    print("hello");
    print(res.status);

      return res;

  }
}
