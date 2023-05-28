import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hc_dapp/Utils/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hc_dapp/utils.dart';
import 'package:hc_dapp/Services/Contracts.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;
import 'package:web3dart/web3dart.dart';
class DoctorLoginPage extends StatefulWidget {
  const DoctorLoginPage({Key? key}) : super(key: key);

  @override
  State<DoctorLoginPage> createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  bool adding = false;
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 80, 16, 0),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Color(0xffffffff)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      width: 100,
                      height: 120,
                      child: Image.asset(
                        'assets/icons/logo_mydoc.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      // signupfortwinklez29 (324:336)
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 28),
                      child: Text(
                        'Sign In For MYDOC',
                        style: SafeGoogleFont(
                          'Cuprum',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 1.4,
                          color: Color(0xff0a0a0a),
                        ),
                      ),
                    ),
                    Container(
                      // buttoncpD (324:339)
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      width: 365,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Color(0x1905c1ff),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'DOCTOR PANEL',
                          style: SafeGoogleFont(
                            'Cuprum',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            color: Color(0xff05c0ff),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: CupertinoFormSection(
                        backgroundColor: Colors.transparent,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffe0e0e0)),
                          color: Color(0xffffffff),
                          //borderRadius: BorderRadius.circular(8),
                        ),
                        children: [
                          CupertinoFormRow(
                            //padding: EdgeInsets.only(left: 0),
                            child: CupertinoTextFormFieldRow(
                              style: GoogleFonts.poppins(),
                              //controller: address,
                              placeholder: "Enter your Etherium Address",
                              prefix: Text(
                                "Address      ",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              padding: const EdgeInsets.only(left: 0),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Address can't be empty";
                                }
                                return null;
                              },
                              controller: addressController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: CupertinoFormSection(
                        backgroundColor: Colors.transparent,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffe0e0e0)),
                          color: Color(0xffffffff),
                          //borderRadius: BorderRadius.circular(12),
                        ),
                        children: [
                          CupertinoFormRow(
                            //padding: EdgeInsets.only(left: 0),
                            child: CupertinoTextFormFieldRow(
                              style: GoogleFonts.poppins(),
                              //controller: privateKey,
                              placeholder: "Enter your private key",
                              prefix: Text(
                                "Key      ",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              padding: const EdgeInsets.only(left: 0),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Key can't be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        // Background image or color
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 32, 0, 48),
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            // onPressed: () => moveToHome(),
                            onPressed: () {
                              // Navigate to next screen when button is pressed
                              Navigator.pushReplacementNamed(
                                  context,
                                  MyRoutes
                                      .doctorHomePage); // configure next page here !!
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff05c0ff),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: Size(365, 56),
                            ),
                            child: Text(
                              'Sign In',
                              style: SafeGoogleFont(
                                'Cuprum',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      // bysigninginyouagreetoourtermof (324:337)
                      constraints: BoxConstraints(
                        maxWidth: 323,
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: SafeGoogleFont(
                            'Cuprum',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.3333333333,
                            color: Color(0xff0a0a0a),
                          ),
                          children: [
                            TextSpan(
                              text: 'By signing in, you agree to our',
                              style: SafeGoogleFont(
                                'Cuprum',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 1.3333333333,
                                color: Color(0xff707070),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                              style: SafeGoogleFont(
                                'Cuprum',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 1.3333333333,
                                color: Color(0xff0a0a0a),
                              ),
                            ),
                            TextSpan(
                              text: 'Term of service',
                              style: SafeGoogleFont(
                                'Cuprum',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                height: 1.3333333333,
                                color: Color(0xff0a0a0a),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                              style: SafeGoogleFont(
                                'Cuprum',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 1.3333333333,
                                color: Color(0xff0a0a0a),
                              ),
                            ),
                            TextSpan(
                              text: 'and acknowledge that you have read our',
                              style: SafeGoogleFont(
                                'Cuprum',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 1.3333333333,
                                color: Color(0xff707070),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                              style: SafeGoogleFont(
                                'Cuprum',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 1.3333333333,
                                color: Color(0xff0a0a0a),
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy.',
                              style: SafeGoogleFont(
                                'Cuprum',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                height: 1.3333333333,
                                color: Color(0xff0a0a0a),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
