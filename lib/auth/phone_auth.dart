import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phone_auth_app/controller/phone_auth_controller.dart';

class PhoneAuthScreen extends StatelessWidget {
  PhoneAuthController controller = Get.put(PhoneAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Phone Auth"),
          centerTitle: true,
          elevation: 0,
        ),
        body: GetBuilder<PhoneAuthController>(
          builder: (_) => Padding(
            padding: EdgeInsets.all(16),
            // lets add form for phone and code auth
            child: Form(
              key: controller.formKey,
              child: Column(
                // we want all these widgets to show in center of screen so

                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  //we need to add two textfields 1. one for the phone number
                  //2. for code authentication

                  TextFormField(
                    controller: controller.phoneController,
                    inputFormatters: [maskFormatter],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        //lets add hint and lebel here
                        hintText: "03472222",
                        labelText: "Phone Number"),

                    // lets add validation
                    validator: (String? number) {
                      if (number!.isEmpty) {
                        return "Enter Phone Number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // same we need to add code text field for phone number auhtenictaion
                  Visibility(
                    visible: controller.isCodeSent,
                    child: TextFormField(
                      controller: controller
                          .codeController, // we need to create controller
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: const InputDecoration(
                          //lets add hint and lebel here
                          hintText: "123456",
                          labelText: "Code"),

                      // lets add validation
                      validator: (String? code) {
                        if (code!.isEmpty) {
                          return "Enter Code";
                        } else if (code.length < 6) {
                          return "Code should be of length 6";
                        }

                        return null;
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Visibility(
                    visible: controller.isCodeSent,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              if (controller.formKey.currentState!
                                  .validate()) {
                                controller.verifyOtp();
                              }
                            },
                            child: const Text('Verify'))),
                  ),
                  Visibility(
                    visible: !controller.isCodeSent,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {

                                controller.sendSms();
                                controller.showInvisibleWgts();
                              }
                            },
                            child: const Text('Submit'))),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '+## (###) ###-##-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
}
