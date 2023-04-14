import 'package:flutter/material.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/UI/ConsumerTab.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:lifestyle/res/Strings.dart';

class WalletSendReceiveGift extends StatefulWidget {
  var receiverPhoneNo,prgmimgurl;
   WalletSendReceiveGift(this.receiverPhoneNo,this.prgmimgurl,{Key? key}) : super(key: key);

  @override
  State<WalletSendReceiveGift> createState() => _WalletSendReceiveGiftState(this.receiverPhoneNo,this.prgmimgurl);
}

class _WalletSendReceiveGiftState extends State<WalletSendReceiveGift> {
  var receiverPhoneNo,prgmimgurl;
  _WalletSendReceiveGiftState(this.receiverPhoneNo,this.prgmimgurl);
  void initState(){
    print("bhar"+prgmimgurl.toString());

}
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(backgroundColor: Maincolor,
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text("Send Gift",style: TextStyle(color: Whitecolor),),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
            CommonUtils.NAVIGATE_PATH=CommonUtils.walletPage;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ConsumerTab()));
          },
          color: Colors.white,
          icon:Icon(Icons.arrow_back),
          //replace with our own icon data.
        ),),
       body: WillPopScope(

         onWillPop: () async{
           Navigator.pop(context);
           CommonUtils.NAVIGATE_PATH=CommonUtils.walletPage;
           Navigator.pushReplacement(
               context, MaterialPageRoute(builder: (_) => ConsumerTab()));
           return true;
         },
         child: Padding(
           padding: const EdgeInsets.all(10.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               SizedBox(height: 10,),
               Center(child: Image.asset("assets/ic_sendmail.png",fit: BoxFit.fill,height: 50)),
               SizedBox(height: 10,),
               Text("Your voucher has been sent to " + receiverPhoneNo.toString() ,style: TextStyle(fontSize: 14),),
               SizedBox(height: 10,),
               Center(child: ClipRRect(
                 borderRadius: BorderRadius.circular(10.0),
                 child: Container(
                     width: MediaQuery.of(context).size.width/1.5,
                     height: MediaQuery.of(context).size.height/3.5,
                     child: Stack(
                       children:[
                         Image.asset("assets/img_giftboxbg.png",width: MediaQuery.of(context).size.width/1.5,
                           height: MediaQuery.of(context).size.height/3.5, ),
                         Padding(
                           padding: const EdgeInsets.only(top:70.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               //SizedBox(width: 20,),
                               Center(
                                 child: Image.network(prgmimgurl,
                                   width: MediaQuery.of(context).size.width/2,height:MediaQuery.of(context).size.width/5),
                               ),
                               SizedBox(height: 15,),
                                InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                    CommonUtils.NAVIGATE_PATH=CommonUtils.walletPage;
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (_) => ConsumerTab()));
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 75,
                                    decoration: BoxDecoration(
                                      color: Maincolor,

                                      borderRadius: BorderRadius.circular(22.5),

                                    ),

                                    child: Center(
                                      child: Text("Ok",style: TextStyle(
                                          color: Whitecolor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),

                             ],
                           ),
                         ),

                       ],
                     )

                 ),
               )),
               SizedBox(height: 10,),
               Text(sendgift_desc,style: TextStyle(fontSize: 14),maxLines: 3,),
             ],
           ),
         ),
       ),
    ));
  }
}
