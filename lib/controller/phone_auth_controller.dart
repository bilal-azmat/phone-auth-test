import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class PhoneAuthController extends GetxController{

  final formKey=GlobalKey<FormState>();
  TextEditingController phoneController=TextEditingController();
  TextEditingController codeController=TextEditingController();

  late TwilioFlutter twilioFlutter;

  var sentCode;

  var isCodeSent=false;
  var submitButtonShowing=true;




  showInvisibleWgts(){
    isCodeSent=true;
    update();
  }

  sendSms(){

    twilioFlutter = TwilioFlutter(
        accountSid : 'Cd72d0ce07674fa94ca61e54e8c896d50', // replace *** with Account SID
        authToken : 'c10fcfebbadcf85deb66f1959893aa6a',  // replace xxx with Auth Token
        twilioNumber : '+18586486095'  // replace .... with Twilio Number
    );

    var rng = new Random();
    var digits = rng.nextInt(900000) + 100000;
    sentCode=digits;
    twilioFlutter.sendSMS(
        toNumber : phoneController.text,
        messageBody : 'hello world here is you otp code $digits');
    print(sentCode);



  }


  verifyOtp(){
    print(sentCode);
    print(codeController.text);
    if(sentCode.toString()==codeController.text){
      print("code sent ");
    }else{
      print("failed to sent code");
    }
  }

  // hideSubmitButton(){
  //   submitButtonShowing=false;
  //   update();
  // }


}