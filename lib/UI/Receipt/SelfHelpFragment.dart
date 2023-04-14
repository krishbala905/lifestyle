import 'dart:async';
import 'dart:convert';
import 'dart:ui';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lifestyle/UI/Receipt/Model/CategoryModel.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:lifestyle/res/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import 'Model/RetailerMasterDataModel.dart';
import 'package:xml2json/xml2json.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';


class SelfHelpFragment extends StatefulWidget {

  SelfHelpFragment({Key? key}) : super(key: key);

  @override
  State<SelfHelpFragment> createState() => _SelfHelpFragmentState();
}

class _SelfHelpFragmentState extends State<SelfHelpFragment> {
  String retailer_temp_hint="Mall";
  String retailer_temp_hint1="Mall";
  String catId="";
  String catId1="";

  List<RetailerMasterDataModel> posts1=[];
  List<RetailerMasterDataModel> posts2=[];


  var receiptNo_cntrl=new TextEditingController();
  var receiptNo_cntrl1=new TextEditingController();

  var purchasedAmount_cntrl=new TextEditingController();
  var purchasedAmount_cntrl1=new TextEditingController();

  var dateinputTxt=new TextEditingController();
  var dateinputTxt1=new TextEditingController();

  var retailerName;
  var retailerName1;
  var retId,retName;
  var retId1,retName1;

  bool nextBool=true;
  bool prevBool=false;

  var categoryName="";
  var categoryName1="";


  List<dynamic> categoryList=[];
  List<dynamic> categoryList1=[];


  String receipt_name="First Receipt";

  @override
  void initState() {
    // TODO: implement initState
    String de=DateFormat('dd-MM-yyyy').format(DateTime.now());
    dateinputTxt.text=de;

    getDataForDropDownLoader();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6,sigmaY: 6),
        child: AlertDialog(
          alignment: Alignment.topCenter,
          backgroundColor: Colors.white,
          content:  SingleChildScrollView(
            child: Container(

              width: width-50,
              height: 420,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex:1,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(

                              onTap: () {
                                CommonUtils.isSecondImagePresent=0;
                                Navigator.pop(context);},
                              child: Icon(Icons.close,size: 20,color: poketPurple,)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if(CommonUtils.isSecondImagePresent==1)
                              Visibility(
                                visible: nextBool,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: (){

                                      setState(() {
                                        nextBool=false;
                                        prevBool=true;
                                        categoryName1=categoryName1.toString();
                                        receipt_name="Second Receipt";
                                      });
                                    },
                                    child: Text("Next Receipt",style: TextStyle(color: Colors.red,fontSize: 12),),

                                  ),
                                ),
                              ),

                            if(CommonUtils.isSecondImagePresent==1)
                              Visibility(
                                visible: prevBool,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        nextBool=true;
                                        prevBool=false;
                                        categoryName=categoryName.toString();
                                        receipt_name="First Receipt";
                                      });
                                    },
                                    child: Text("Previous Receipt",style: TextStyle(color: Colors.red,fontSize: 12),),

                                  ),
                                ),
                              ),
                          ],
                        ),

                      )

                    ],
                  ),


                  const SizedBox(height: 15,),

                  if(CommonUtils.isSecondImagePresent==1)Text(receipt_name,style: TextStyle(fontSize: 14,color: lightGrey),),

                  Visibility(
                      visible: nextBool,
                      child: firstImageDetailsLayout(context)),

                  Visibility(
                      visible: prevBool,
                      child: secondImageDetailsLayout(context)),


                  SizedBox(height: 15,),

                  Center(
                    child: InkWell(

                      onTap: (){

                        if(CommonUtils.isSecondImagePresent!=1){
                          if(retailer_temp_hint=="Mall"){
                            showAlertDialog_oneBtn(context, alert, "Please enter mall");
                          }
                          else if(categoryName==""){
                            showAlertDialog_oneBtn(context, alert, "Please enter retailer");
                          }
                          else if(receiptNo_cntrl.text.isEmpty){
                            showAlertDialog_oneBtn(context, alert, "Please enter receipt no");
                          }
                          else if(purchasedAmount_cntrl.text.isEmpty){
                            showAlertDialog_oneBtn(context, alert, "Please enter amount");
                          }
                          else{
                            // Submit
                            callApiForSROUploadData(context, CommonUtils.imageFileForReceipt, receiptNo_cntrl.text, dateinputTxt.text, purchasedAmount_cntrl.text, retId, categoryName,
                                "", "", "", "", "", "");
                          }


                        }
                        else{
                          if(retailer_temp_hint=="Mall"){
                            showAlertDialog_oneBtn(context, alert, "Please enter mall");
                          }
                          else if(categoryName==""){
                            showAlertDialog_oneBtn(context, alert, "Please enter retailer");
                          }
                          else if(receiptNo_cntrl.text.isEmpty){
                            showAlertDialog_oneBtn(context, alert, "Please enter no");
                          }
                          else if(purchasedAmount_cntrl.text.isEmpty){
                            showAlertDialog_oneBtn(context, alert, "Please enter amount");
                          }
                          else if(nextBool==true && retailer_temp_hint1=="Mall"){
                            showAlertDialog_oneBtn(context, alert, "Please enter details for the next receipt");
                          }

                          else if(retailer_temp_hint1=="Mall"){
                            showAlertDialog_oneBtn(context, alert, "Please enter mall");
                          }
                          else if(categoryName1==""){
                            showAlertDialog_oneBtn(context, alert, "Please enter retailer");
                          }
                          else if(receiptNo_cntrl1.text.isEmpty){
                            showAlertDialog_oneBtn(context, alert, "Please enter no");
                          }
                          else if(purchasedAmount_cntrl1.text.isEmpty){
                            showAlertDialog_oneBtn(context, alert, "Please enter amount");
                          }
                          else{
                            // Submit

                            callApiForSROUploadData(context,
                                CommonUtils.imageFileForReceipt, receiptNo_cntrl.text, dateinputTxt.text, purchasedAmount_cntrl.text, retId, categoryName,
                                CommonUtils.imageFileForReceipt1, receiptNo_cntrl1.text, dateinputTxt1.text, purchasedAmount_cntrl1.text, retId1, categoryName1);


                          }
                        }


                      },
                      child: Container(
                        width: 220,
                        height: 45,
                        decoration: BoxDecoration(
                          color: corporateColor,
                            borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: corporateColor
                          )

                        ),
                        child: Center(child: Text(submit_small,style: TextStyle(color: Colors.white,fontSize: 14),)),
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),

        ),
      ),
    );

  }


  void showAlertDialog_oneBtn(BuildContext context,String tittle,String message)
  {
    AlertDialog alert = AlertDialog(

      backgroundColor: Colors.white,
      title: Text(tittle),
      // content: CircularProgressIndicator(),
      content: Text(message,style: TextStyle(color: Colors.black45,fontSize: 15)),
      actions: [
        GestureDetector(
          onTap: (){Navigator.pop(context,true);},
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 35,
              width: 100,
              color: Colors.white,
              child:Center(child: Text(ok,style: TextStyle(color: corporateColor),)),
            ),
          ),
        ),
      ],
    );
    showDialog(

      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6,sigmaY: 6),
          child: alert,
        );
      },
    );
  }

  Future<void> getDataForDropDownLoader()async{

    final http.Response response = await http.post(
      Uri.parse(SHOP_CATEGORY_URL),

      body: {

        "consumer_id": CommonUtils.consumerID.toString(),
        "os_version":"31",
        "consumer_application_type":"22",
        "software_version":"1.1",
        "device_model":"1.1",
        "consumer_language_id":"1.1",
      },
    ).timeout(Duration(seconds: 30));



   var data=jsonDecode(response.body);
    print("D1:"+response.body.toString());


    List<dynamic> body = data["data"];
    List<RetailerMasterDataModel> posts = body.map((dynamic item) => RetailerMasterDataModel.fromJson(item),).toList();


    setState(() {

      posts1=posts;
      posts2=posts;

      // posts1=posts;
    });
    List<String> retName=[];
    List<String> retId=[];
    for(int i=0;i<posts1.length;i++){
      retName.add(posts1[i].Retailername.toString());
      retId.add(posts1[i].Retailerid.toString());

    }
  }

  clearAllSpinners(){
    setState(() {
      retailerName=null;
      posts1=[];
      retailer_temp_hint="Mall";

    });
  }

  Widget firstImageDetailsLayout(BuildContext context){

  return Column(
  children: [

  Container(
  decoration: BoxDecoration(
  border: Border.all(color: lightGrey),
  borderRadius: BorderRadius.circular(5)
  ),
  height: 50,
  width: double.infinity,
  child: DropdownButtonHideUnderline(
  child: ButtonTheme(
  alignedDropdown: true,
  child: DropdownButton(
  isExpanded: true,
  hint: Text(retailer_temp_hint,style:const TextStyle(fontSize: 14,color: lightGrey )),
  style:const TextStyle(color: lightGrey),
  items: posts1.map((data)  {

  return DropdownMenuItem(
  value:data,


  child: Text(data.Retailername,
  style:const TextStyle(fontSize: 14,color: lightGrey),),
  );



  }).toList(),

  onChanged: (value) {

  var d=jsonEncode(value);
  var m=jsonDecode(d);
  setState(() {
  retailerName=value;


  categoryList=[];

  retId=m["cat_name"].toString();
  retName=m["cat_id"].toString();
  retailer_temp_hint=m["cat_id"].toString();

  categoryList=m["item_data"];

  });


  },
  value: retailerName==null ? null : retailerName,
  ),
  ),
  ),

  ),

  const SizedBox(height: 10,),

  // rawAutoCompleteWidget(context),
  AutoCompleteMerchantField(context),
  Container(height: 1,color: lightGrey,),
  const SizedBox(height: 10,),
  // Receipt No
  Row(
  children: [
  Image.asset("assets/ic_receiptnumber.png",color: poketBlue2,width: 30,height: 30,),

  Expanded(
  flex: 2,
  child: Padding(
  padding: const EdgeInsets.only(left: 10),
  child: TextField(
  cursorColor: textColor,
  controller: receiptNo_cntrl,
  keyboardType: TextInputType.text,
  style: TextStyle( fontSize: 14),
  inputFormatters: <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z]')),
  ],
  decoration: InputDecoration(
  hintText: "Enter Receipt No",
  hintStyle: TextStyle(

  fontSize: 14,
  color: lightGrey


  ),

  border: InputBorder.none,
  ),
  ),
  ),

  ),
  ],
  ),
  Container(height: 1,color: lightGrey,),
  const SizedBox(height: 10,),
  // Purchased Amount
  Row(
  children: [
  Image.asset("assets/ic_amount.png",width: 30,height: 30,),
  Expanded(
  flex: 2,
  child: Padding(
  padding: const EdgeInsets.only(left: 10),
  child: TextField(
  cursorColor: textColor,
  controller: purchasedAmount_cntrl,
  keyboardType: TextInputType.number,
  style: TextStyle( fontSize: 14),
  inputFormatters: <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
  ],
  decoration: InputDecoration(
  hintText: "Total Purchased Amount",
  hintStyle: TextStyle(

  fontSize: 14,
  color: lightGrey


  ),

  border: InputBorder.none,
  ),
  ),
  ),

  ),

  ],
  ),
  Container(height: 1,color: lightGrey,),
  const SizedBox(height: 10,),
  // Date Purchased
  Row(
  children: [
  Image.asset("assets/ic_receiptdate.png",width: 30,height: 30,),

  Expanded(
  flex : 2,
  child: Container(

  padding: EdgeInsets.only(left: 10),
  child: TextField(

  controller: dateinputTxt,
  keyboardType: TextInputType.text,
  decoration: const InputDecoration(

  hintStyle: TextStyle(

      ),

  border: InputBorder.none,
  ),
  readOnly: true,
  onTap: () async {
  DateTime? pickedDate = await showDatePicker(
  context: context,
  initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(Duration(days:7)),
  lastDate: DateTime.now(),
  builder: (context, child) {
  return Theme(
  data: Theme.of(context).copyWith(
  colorScheme: const ColorScheme.light(
  primary: corporateColor, // <-- SEE HERE
  onPrimary: Colors.white, // <-- SEE HERE
  onSurface: Colors.black, // <-- SEE HERE
  ),
  textButtonTheme: TextButtonThemeData(
  style: TextButton.styleFrom(
  primary: corporateColor, // button text color
  ),
  ),
  ),
  child: child!,
  );
  },
  );
  if (pickedDate != null) {
  print(
  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
  String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
  print(
  formattedDate); //formatted date output using intl package =>  2021-03-16
  //you can implement different kind of Date Format here according to your requirement

  setState(() {
  dateinputTxt.text =
  formattedDate; //set output date to TextField value.
  });
  } else {
  print("Date is not selected");
  }
},
style:const TextStyle(

fontSize: 14,

),
),

))
],
),
Container(width: double.infinity,height: 1,color: lightGrey,),
const SizedBox(height: 5,),

],

);
}


  Widget secondImageDetailsLayout(BuildContext context){

    return Column(
      children: [

        Container(
          decoration: BoxDecoration(
              border: Border.all(color: lightGrey),
              borderRadius: BorderRadius.circular(5)
          ),
          height: 50,
          width: double.infinity,
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                isExpanded: true,
                hint: Text(retailer_temp_hint1,style:const TextStyle(fontSize: 14,color: lightGrey )),
                style:const TextStyle(color: lightGrey),
                items: posts2.map((data)  {

                  return DropdownMenuItem(
                    value:data,


                    child: Text(data.Retailername,
                      style:const TextStyle(fontSize: 14,color: lightGrey),),
                  );



                }).toList(),

                onChanged: (value) {

                  var d=jsonEncode(value);
                  var m=jsonDecode(d);
                  setState(() {
                    retailerName1=value;


                    categoryList1=[];

                    retId1=m["cat_name"].toString();
                    retName1=m["cat_id"].toString();
                    retailer_temp_hint1=m["cat_id"].toString();

                    categoryList1=m["item_data"];

                  });


                },
                value: retailerName1==null ? null : retailerName1,
              ),
            ),
          ),

        ),

        const SizedBox(height: 10,),

        // rawAutoCompleteWidget(context),
        AutoCompleteMerchantField2(context),
        Container(height: 1,color: lightGrey,),
        const SizedBox(height: 10,),
        // Receipt No
        Row(
          children: [
            Image.asset("assets/ic_receiptnumber.png",color: poketBlue2,width: 30,height: 30,),

            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  cursorColor: textColor,
                  controller: receiptNo_cntrl1,
                  keyboardType: TextInputType.text,
                  style: TextStyle( fontSize: 14),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z]')),
                  ],
                  decoration: InputDecoration(
                    hintText: "Enter Receipt No",
                    hintStyle: TextStyle(

                        fontSize: 14,
                        color: lightGrey


                    ),

                    border: InputBorder.none,
                  ),
                ),
              ),

            ),
          ],
        ),
        Container(height: 1,color: lightGrey,),
        const SizedBox(height: 10,),
        // Purchased Amount
        Row(
          children: [
            Image.asset("assets/ic_amount.png",width: 30,height: 30,),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  cursorColor: textColor,
                  controller: purchasedAmount_cntrl1,
                  keyboardType: TextInputType.number,
                  style: TextStyle( fontSize: 14),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  decoration: InputDecoration(
                    hintText: "Total Purchased Amount",
                    hintStyle: TextStyle(

                        fontSize: 14,
                        color: lightGrey


                    ),

                    border: InputBorder.none,
                  ),
                ),
              ),

            ),

          ],
        ),
        Container(height: 1,color: lightGrey,),
        const SizedBox(height: 10,),
        // Date Purchased
        Row(
          children: [
            Image.asset("assets/ic_receiptdate.png",width: 30,height: 30,),

            Expanded(
                flex : 2,
                child: Container(

                  padding: EdgeInsets.only(left: 10),
                  child: TextField(

                    controller: dateinputTxt1,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(

                      hintStyle: TextStyle(

                      ),

                      border: InputBorder.none,
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days:7)),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: corporateColor, // <-- SEE HERE
                                onPrimary: Colors.white, // <-- SEE HERE
                                onSurface: Colors.black, // <-- SEE HERE
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary: corporateColor, // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dateinputTxt1.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                    style:const TextStyle(

                      fontSize: 14,

                    ),
                  ),

                ))
          ],
        ),
        Container(width: double.infinity,height: 1,color: lightGrey,),
        const SizedBox(height: 5,),

      ],

    );
  }

  Widget  AutoCompleteMerchantField(BuildContext context){

    return Autocomplete(optionsBuilder: (textEditingValue) {
      List<CategoryModel> categListss=[];

      for(int i=0 ; i<categoryList.length;i++){
        if(categoryList[i]["item_name"].toString().toLowerCase().contains(textEditingValue.text.toLowerCase())){
          categListss.add(new CategoryModel(categoryList[i]["item_name"], categoryList[i]["item_id"]));
        }
      }


      return categListss;
    },

    onSelected: (CategoryModel option) {

      categoryName=option.item_name;
      catId =option.item_id;
    },

      fieldViewBuilder: (
          BuildContext context,
           fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted
          ) {
      fieldTextEditingController.text=categoryName.toString();
        return TextField(
          decoration: InputDecoration(
            hintText: "Enter Retailer",
              hintStyle:const TextStyle(fontSize: 14, color: lightGrey),
            border: InputBorder.none,
            icon: Image.asset("assets/ic_retailer.png",width: 30,height: 30,)
                
          ),
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,

        );
      },
      
      displayStringForOption: (CategoryModel option) => option.item_name,
      optionsViewBuilder: (
          BuildContext context,
          AutocompleteOnSelected<CategoryModel> onSelected,
          Iterable<CategoryModel> options
          ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: 300,

              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final CategoryModel option = options.elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(option.item_name, style: const TextStyle(
                          color: Colors.black)),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },


    );

}

  Widget  AutoCompleteMerchantField2(BuildContext context){

    return
      Autocomplete(optionsBuilder: (textEditingValue) {
      List<CategoryModel> categListss=[];

      for(int i=0 ; i<categoryList1.length;i++){
        if(categoryList1[i]["item_name"].toString().toLowerCase().contains(textEditingValue.text.toLowerCase())){
          categListss.add(new CategoryModel(categoryList[i]["item_name"], categoryList[i]["item_id"]));
        }
      }


      return categListss;
    },

    onSelected: (CategoryModel option) {


      categoryName1=option.item_name;
      catId1=option.item_id;
    },


      fieldViewBuilder: (
          BuildContext context,
           fieldTextEditingController1,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted
          )
      {
        fieldTextEditingController1.text=categoryName1;
        return TextField(

          decoration: InputDecoration(
            hintText: "Enter Retailer",
              hintStyle:const TextStyle(fontSize: 14, color: lightGrey),
            border: InputBorder.none,
            icon: Image.asset("assets/ic_retailer.png",width: 30,height: 30,)

          ),
          controller: fieldTextEditingController1,
          focusNode: fieldFocusNode,

        );
      },

      displayStringForOption: (CategoryModel option) => option.item_name,
      optionsViewBuilder: (
          BuildContext context,
          AutocompleteOnSelected<CategoryModel> onSelected,
          Iterable<CategoryModel> options
          ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: 300,

              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final CategoryModel option = options.elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(option.item_name, style: const TextStyle(
                          color: Colors.black)),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },


    );

}


  Future <dynamic>  callApiForSROUploadData(BuildContext buildContext,
      var ImageData,var rcptNo,var rcptDate , var amount,var mall, var product,
      var ImageData1,var rcptNo1,var rcptDate1 , var amount1,var mall1, var product1

      ) async{


    showLoadingView(buildContext);

    var stream =
    new http.ByteStream(DelegatingStream.typed(ImageData.openRead()));
    var length = await ImageData.length();

    
    var uri = Uri.parse(SRORECEIPTUPLOAD_URL);

    print("1:"+CommonUtils.consumerID.toString());
    print("2:"+mall);
    print("3:"+categoryName);
    print("4:"+catId);
    print("5:"+rcptNo);
    print("6:"+rcptDate);
    print("7:"+amount);
    print("2:"+mall1);
    print("3:"+categoryName1);
    print("4:"+catId1);
    print("5:"+rcptNo1);
    print("6:"+rcptDate1);
    print("7:"+amount1);
    var request = new http.MultipartRequest("POST", uri);

    request.fields["consumer_id"] = CommonUtils.consumerID.toString();
    request.fields["official_retailer"] = mall;
    request.fields["retailer_text"] = categoryName;
    request.fields["retail_outlet"] = catId;
    request.fields["receipt_no"] = rcptNo;
    request.fields["receipt_date"] = rcptDate;
    request.fields["amount"] = amount;

    request.fields["srotype"] = "2";
    request.fields["action_event"] = "";
    request.fields["program_id"] = "";
    request.fields["country_index"] = "191";
    request.fields["merchant_id"] = "1";
    request.fields["device_token"] = CommonUtils.deviceToken.toString();
    request.fields["filename"] = CommonUtils.imageFileName.toString();

    var multipartFile = new http.MultipartFile('scanning_photo', stream, length,
        filename: basename(ImageData.path),
        contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);


    if(CommonUtils.isSecondImagePresent==1){
      var stream1 =
      new http.ByteStream(DelegatingStream.typed(ImageData1.openRead()));
      var length1 = await ImageData1.length();

      request.fields["receipt_no1"] = rcptNo1;
      request.fields["official_retailer1"] = mall1;
      request.fields["retailer_text1"] = categoryName1;
      request.fields["retail_outlet1"] = catId1;
      request.fields["receipt_date1"] = rcptDate1;
      request.fields["amount1"] = amount1;
      var multipartFile1 = new http.MultipartFile('scanning_photo1', stream1, length1,
          filename: basename(ImageData1.path),
          contentType: new MediaType('image', 'png'));
      request.files.add(multipartFile1);
    }

    var response = await request.send();

    if(response.statusCode==200){
      print("ImageUploadResponse:"+response.toString());
      Navigator.pop(buildContext);
      final Xml2Json xml2json = new Xml2Json();
      response.stream.transform(utf8.decoder).listen((value) {
        xml2json.parse(value);
        var jsonstring = xml2json.toParker();

        var data = jsonDecode(jsonstring);
        var data2 = data['info'];
        var status=data2["p1"].toString();
        if(status=="1"){
          showAlertDialog_oneBtnWitDismiss(buildContext, alert, data2["p3"].toString().split("*%8%*")[0]);
        }
        else{
          showAlertDialog_oneBtnWitDismiss(buildContext, alert, data2["p3"].toString().split("*%8%*")[0]);
        }
      });
    }
    else{
      Navigator.pop(buildContext);
      print("Something Went Wrong");
    }

  }


@override
  void dispose() {
    // TODO: implement dispose
  receiptNo_cntrl.dispose();
  receiptNo_cntrl1.dispose();
  purchasedAmount_cntrl.dispose();
  purchasedAmount_cntrl1.dispose();
  dateinputTxt.dispose();
  dateinputTxt1.dispose();

    CommonUtils.isSecondImagePresent=0;
    super.dispose();
  }

}


