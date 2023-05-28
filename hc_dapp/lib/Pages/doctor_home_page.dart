import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hc_dapp/Services/Contracts.dart';
import 'package:hc_dapp/Utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:developer' as dev;
class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  TextEditingController patientAddress = TextEditingController();
  TextEditingController diagnosis = TextEditingController();
  TextEditingController medicines = TextEditingController();
  TextEditingController advice = TextEditingController();
  bool isAuthorized = false;
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    var contracts = Provider.of<Contracts>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 8,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      FontAwesomeIcons.userDoctor,
                      color: Colors.white,
                      size: 40,
                    ),
                    VerticalDivider(
                      color: Colors.white,
                      // thickness: 5,
                    ),
                    Text(
                      'Doctor Panel',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        // color: Colors.green.shade50,
                        color: Color.fromARGB(255, 195, 225, 222),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                          child: Text(
                            contracts.doctorData,
                            style: TextStyle(
                                fontSize:
                                    (MediaQuery.of(context).size.width * 0.05),
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 75, 78, 75)),
                          ),
                          ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.popAndPushNamed(context, MyRoutes.selectionPage);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          // color: Colors.red.shade50,
                          color: Color(0xff05c0ff),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                fontSize:
                                    (MediaQuery.of(context).size.width * 0.03),
                                // fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 249, 247, 247)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              showLoading == false
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 16, top: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                // width: 250,
                                height: 50,
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      // FontAwesomeIcons.prescriptionBottle,
                                      FontAwesomeIcons.notesMedical,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: VerticalDivider(
                                        color: Colors.black,
                                        thickness: 1,
                                      ),
                                    ),
                                    Text(
                                      'Add Record',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
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
                                      controller: patientAddress,
                                      placeholder: "Patient Address",
                                      padding: const EdgeInsets.only(left: 0),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Address cannot be empty.";
                                        }
                                        return null;
                                      },
                                      prefix: Text(
                                        'Address  | ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  if (patientAddress.text.length != 40) {
                                    Fluttertoast.showToast(msg: "Wrong address");
                                  }else{                                  
                                   bool auth= await contracts.checkPermission(EthereumAddress.fromHex(patientAddress.text));
                                    setState(() {
                                    showLoading = true;
                                    isAuthorized= auth;
                                  });
                                  }
                                  if (!isAuthorized) {
                                    Fluttertoast.showToast(
                                        msg: "You are not authorized to give prescription.");
                                  }
                                  setState(() {
                                    showLoading = false;
                                  });
                                },
                                child: Container(
                                    width: 200,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        'Check Authorization',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    )),
                              ),
                            ),
                            isAuthorized
                                ? Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        CupertinoFormSection(
                                          children: [
                                            CupertinoFormRow(
                                              child: CupertinoTextFormFieldRow(
                                                controller: diagnosis,
                                                // placeholder: "Notes",
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Diagnosis cannot be empty.";
                                                  }
                                                  return null;
                                                },
                                                prefix: Text(
                                                  'Diagnosis  | ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                                expands: true,
                                                maxLength: null,
                                                maxLines: null,
                                              ),
                                            ),
                                            CupertinoFormRow(
                                              child: CupertinoTextFormFieldRow(
                                                controller: medicines,
                                                // placeholder: "Patient Address",
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Medications cannot be empty.";
                                                  }
                                                  return null;
                                                },
                                                prefix: Text(
                                                  'Medications | ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                                expands: true,
                                                maxLength: null,
                                                maxLines: null,
                                              ),
                                            ),
                                            CupertinoFormRow(
                                              child: CupertinoTextFormFieldRow(
                                                controller: advice,
                                                // placeholder: "Advice Address",
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                prefix: Text(
                                                  'Advices  | ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                                expands: true,
                                                maxLength: null,
                                                maxLines: null,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16, bottom: 16),
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () async {
                                                contracts.setPrescription(EthereumAddress.fromHex(patientAddress.text), diagnosis.text, medicines.text,advice.text, DateTime.now().millisecondsSinceEpoch.toString());
                                                    setState(() {
                                                    showLoading = false;
                                                    isAuthorized = false;
                                                  });
                                              },
                                              child: Container(
                                                  width: 100,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        blurRadius: 7,
                                                        offset: const Offset(0,
                                                            3), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Send',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: CupertinoActivityIndicator(
                          radius: 20,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
