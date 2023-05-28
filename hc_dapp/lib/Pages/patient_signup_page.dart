import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hc_dapp/Services/Contracts.dart';
import 'package:hc_dapp/Utils/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hc_dapp/utils.dart';
import 'package:provider/provider.dart';

bool adding = false;

class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({Key? key}) : super(key: key);

  @override
  State<PatientSignupPage> createState() => _PatientSignupPageState();
}

class _PatientSignupPageState extends State<PatientSignupPage> {
  TextEditingController address = TextEditingController();
  TextEditingController privateKey = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController role = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var contracts = Provider.of<Contracts>(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: Color(0xffffffff)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                          width: 100,
                          height: 120,
                          child: Image.asset(
                            'assets/icons/logo_mydoc.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Text(
                            'Sign Up For MYDOC',
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
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                          width: 365,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Color(0x1905c1ff),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'PATIENT PANEL',
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
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                          child: CupertinoFormSection(
                            backgroundColor: Colors.transparent,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffe0e0e0)),
                              color: Color(0xffffffff),
                            ),
                            children: [
                              CupertinoFormRow(
                                child: CupertinoTextFormFieldRow(
                                  style: GoogleFonts.poppins(),
                                  controller: firstName,
                                  placeholder: "Enter your First Name",
                                  prefix: Text(
                                    "First Name      ",
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  padding: const EdgeInsets.only(left: 0),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "First Name can't be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                          child: CupertinoFormSection(
                            backgroundColor: Colors.transparent,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffe0e0e0)),
                              color: Color(0xffffffff),
                            ),
                            children: [
                              CupertinoFormRow(
                                child: CupertinoTextFormFieldRow(
                                  style: GoogleFonts.poppins(),
                                  controller: lastName,
                                  placeholder: "Enter your Last Name",
                                  prefix: Text(
                                    "Last Name      ",
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  padding: const EdgeInsets.only(left: 0),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Last Name can't be empty";
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
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 16, 0, 24),
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Navigate to next screen when button is pressed
                                  await contracts.addPatient(firstName.text, lastName.text);
                                  await contracts.displayPatient();
                                  Navigator.pushReplacementNamed(
                                      context, MyRoutes.patientHomePage);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff05c0ff),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  minimumSize: Size(365, 56),
                                ),
                                child: Text(
                                  'Sign Up',
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
                                  text: 'By signing up, you agree to our',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
