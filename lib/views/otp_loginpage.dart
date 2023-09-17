import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../utills/helper/firebase_auth_helper.dart';
import '../../utills/utills.dart';

class otpLogainpage extends StatefulWidget {
  const otpLogainpage({super.key});

  static String verify = "";

  @override
  State<otpLogainpage> createState() => _otpLogainpageState();
}

class _otpLogainpageState extends State<otpLogainpage> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
  }

  // String dialCodeDigit = "+00";
  GlobalKey<FormState> otploginformkey = GlobalKey<FormState>();

  // authWithNumber controller = Get.put(authWithNumber());
  String phonenumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: otploginformkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   'assets/img1.png',
                //   width: 150,
                //   height: 150,
                // ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Phone Verification",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "We need to register your phone without getting started!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: countryController,
                          validator: (val) {
                            (val!.isEmpty) ? "Please enter country code" : null;
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (val) {
                            (val!.isEmpty)
                                ? "Please enter phone number.."
                                : null;
                          },
                          onChanged: (val) {
                            phonenumber = val;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone Number",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (otploginformkey.currentState!.validate()) {
                        otploginformkey.currentState!.validate();

                        await FirebaseAuthHelper.firebaseAuth.verifyPhoneNumber(
                          phoneNumber: countryController.text + phonenumber,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            otpLogainpage.verify = verificationId;
                            Get.toNamed('otpverify_page');
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      }
                    },
                    child: const Text(
                      "Send the code",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// return Scaffold(
//   body: Container(
//     alignment: Alignment.center,
//     padding: EdgeInsets.all(16),
//     height: 400,
//     width: double.infinity,
//     child: Form(
//       key: otploginformkey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "Phone Authentication",
//             style: GoogleFonts.aBeeZee(
//               fontWeight: FontWeight.bold,
//               fontSize: 30,
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           SizedBox(
//             width: 400,
//             height: 60,
//             child: CountryCodePicker(
//               dialogTextStyle: GoogleFonts.aBeeZee(color: Colors.black),
//               onChanged: (country) {
//                 setState(() {
//                   dialCodeDigit = country.dialCode!;
//                 });
//               },
//               initialSelection: "IN",
//               showCountryOnly: false,
//               showOnlyCountryWhenClosed: false,
//               favorite: const [
//                 "+91",
//                 "IN",
//                 "+1",
//                 "US",
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(
//               top: 10,
//               right: 10,
//               left: 10,
//             ),
//             child: TextFormField(
//               // maxLength: 10,
//               // keyboardType: TextInputType.number,
//               controller: phoneController,
//               validator: (val) {
//                 if (val!.isEmpty) {
//                   return "Please enter phone number";
//                 }
//                 return null;
//               },
//               decoration: const InputDecoration(
//                 //  prefix:Text("${dialCodeDigit}"),
//                 hintText: "Enter Phone-Number",
//                 label: Text("Phone Number"),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             margin: const EdgeInsets.all(15),
//             height: 40,
//             width: double.infinity,
//
//             child: ElevatedButton(
//               style: const ButtonStyle(
//                 backgroundColor:
//                     MaterialStatePropertyAll(Colors.blueAccent),
//               ),
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     // builder: (context) => OtpScreen(
//                     //   phone: _controller.text,
//                     //   codeDigit: dialCodeDigit,
//                     builder: (context) => Otpverify_page(
//                       phone: phoneController.text,
//                       code: dialCodeDigit,
//                     ),
//                   ),
//                 );
//               },
//               child: const Text(
//                 "Next",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// );
