import 'package:flutter/material.dart';
import 'package:lifestyle/res/Colors.dart';

import 'GiftFragment.dart';
import 'WalletDetailFragment.dart';
import 'WalletViewmodel.dart';

class WalletThirdScreen extends StatefulWidget {
  final WalletViewmodel object1;
   WalletThirdScreen({Key? key,required this.object1}) : super(key: key);

  @override
  State<WalletThirdScreen> createState() => _WalletThirdScreenState(this.object1);
}

class _WalletThirdScreenState extends State<WalletThirdScreen> with SingleTickerProviderStateMixin  {
  late WalletViewmodel object1;
 _WalletThirdScreenState(this.object1);
  late TabController _tabController;
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Maincolor,
        title: Text("Cathay LifeStyle"),
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WalletDetailFragment(Object1: object1,),
          GiftFragment(Object1: object1,),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          indicatorColor: poketPurple,
          labelColor: poketPurple,
          tabs: [
            Tab(child: Container(
              width: 40,
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/ic_walletdetails_normal.png",width: 40,height: 30,),
                  SizedBox(height: 1,),
                  Text("Details",style: TextStyle(fontSize: 10.0),),
                ],
              ),
            ),),
            Tab(child: Container(
              width: 40,
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/ic_wallettofriend_normal.png",width: 40,height: 30,),
                  SizedBox(height: 1,),
                  Text("Gift",style: TextStyle(fontSize: 10.0),),
                ],
              ),
            ),),

          ],
        ),
      ),
    );
  }
}
