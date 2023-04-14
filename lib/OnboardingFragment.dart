import 'package:lifestyle/UI/Login/LoginFragment.dart';
import 'package:lifestyle/UI/Singup/MobileNumberVerification.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:lifestyle/res/Strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Others/Urls.dart';

class OnboardingFragment extends StatefulWidget {
  const OnboardingFragment({Key? key}) : super(key: key);

  @override
  State<OnboardingFragment> createState() => _OnboardingFragmentState();
}

class _OnboardingFragmentState extends State<OnboardingFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
            child: Stack(
              children: [
                //Image.asset('assets/image_bg_main.png',fit: BoxFit.fill),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset('assets/image_bg_main.png',fit: BoxFit.fill),
                    ),

                  ],


                ),
               Positioned(
                  top :MediaQuery.of(context).size.height * 0.4,
                   left: 10,
                   right: 10,
                   child:
                    Column(
                   children: [
                     InkWell(

                       child: Container( height: 45,color: Maincolor,width:MediaQuery.of(context).size.width * 0.7,
                       child: Center(child: Text(login_small_letter,style: TextStyle(
                         color: Whitecolor
                       ),)),
                       ),
                       onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginFragment()));
                       },
                     ),

                     SizedBox(
                       height: 20,
                     ),
                     InkWell(
                       child: Container(height: 45,color: Maincolor,width:MediaQuery.of(context).size.width * 0.7,
                       child:Center(child: Text(createnewaccount,style: TextStyle(
                           color: Whitecolor
                       ),)) ,),
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> MobileNumberVerification()));
                       },
                     ),
                     SizedBox(
                       height: 20,
                     ),
                  SizedBox(
                      width:MediaQuery.of(context).size.width * 0.5,
                    child: Text.rich(

                     TextSpan(
                       style: TextStyle(
                           color: Colors.white
                       ),

                       text: BYsigninyou,
                       children: [
                         TextSpan(text:Termsofervie ,style: TextStyle(
                             decoration: TextDecoration.underline
                         ),
                             recognizer: new TapGestureRecognizer()
                               ..onTap = () async {
                                 final url = TERMS_AND_CONDITION_URL;
                                 if (await canLaunch(url)) launch(url);
                               }
                         ),
                         TextSpan(text: '&  '),
                         TextSpan(text: Privacypolicy,style: TextStyle(
                             decoration: TextDecoration.underline
                         ),
                             recognizer: new TapGestureRecognizer()
                               ..onTap = () async {
                                 final url = PRIVACY_URL;
                                 if (await canLaunch(url)) launch(url);

                               }
                         )

                       ],

                     ),
                     textAlign: TextAlign.center,
                 ),
                  ),
                   ],

                 ),
               )
               // Column(
               //      mainAxisAlignment: MainAxisAlignment.end,
               //      crossAxisAlignment: CrossAxisAlignment.center,
               //      children: [
               //        Row(
               //          children: [
               //            Container(height: 50,color: Colors.white,width:MediaQuery.of(context).size.width * 0.7,)
               //          ],
               //        )
               //
               //      ],
               //    ),


              ],
            ),

        ),
      ),
    );
  }
}
