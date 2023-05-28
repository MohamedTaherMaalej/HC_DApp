import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hc_dapp/Pages/view_prescription.dart';
import 'package:hc_dapp/Services/Contracts.dart';
import 'package:hc_dapp/Utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/credentials.dart';
import 'dart:developer' as dev;
class PatientHomePage extends StatefulWidget {
  const PatientHomePage({Key? key}) : super(key: key);

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  TextEditingController doctorAddress = TextEditingController();
  bool showLoading = true;
  @override
  Widget build(BuildContext context) {
    var contracts = Provider.of<Contracts>(context);
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () async{
        showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    "Authorize Doctor",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    // padding: const EdgeInsets.all(8.0),
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
                              controller: doctorAddress,
                              // obscureText: true,
                              placeholder: "Enter Doctor's Address",
                              // prefix: "Email".text.make(),
                              padding: const EdgeInsets.only(left: 0),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Address can't be empty";
                                }
                                return null;
                              },
                              prefix: Text(
                                'Address  | ',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  InkWell(
                      onTap: () async {
                        await contracts.permission(EthereumAddress.fromHex(doctorAddress.text));
                        Navigator.pop(context);
                        doctorAddress.clear();
                      },
                      child: const SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )))
                ],
              ),
            ),
          );
        });
        },
        child: Container(
          width: (MediaQuery.of(context).size.width / 1.5),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  FontAwesomeIcons.userDoctor,
                  color: Colors.white,
                  size: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: VerticalDivider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),
                Text(
                  'Authorize Doctor',
                  style: TextStyle(
                      // fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
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
                      CupertinoIcons.person_circle,
                      color: Colors.white,
                      size: 40,
                    ),
                    VerticalDivider(
                      color: Colors.white,
                      // thickness: 5,
                    ),
                    Center(
                      child: Text(
                        'Patient Panel',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
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
                            contracts.patientData,
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
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        FontAwesomeIcons.timeline,
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
                        'Medical History',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              (contracts.isLoading== false && contracts.prescriptions.isNotEmpty)
                  ? ListView.builder(
                      itemCount: contracts.prescriptions.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Container(
                                // margin: EdgeInsets.all(16),
                                // height: 100,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: 
                                Row(
                                  children:[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                          color: Colors.black,
                                          child: Text(
                                            "  ${index + 1}  ",
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      thickness: 2,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.clock,
                                              size: 15,
                                              // color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              contracts.prescriptions[index][0].toString(),
                                              style: TextStyle(fontSize: 11),
                                              // style:
                                              //     Theme.of(context).textTheme.caption,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.userDoctor,
                                              size: 15,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  150,
                                              // height: 30,
                                              child: Text(
                                                contracts.prescriptions[index][1],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ),
                                          ],
                                        ),
                                         Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.userDoctor,
                                              size: 15,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  150,
                                              // height: 30,
                                              child: Text(
                                                contracts.prescriptions[index][2],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ),
                                          ],
                                        ),
                                         Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.userDoctor,
                                              size: 15,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  150,
                                              // height: 30,
                                              child: Text(
                                                contracts.prescriptions[index][3],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                    )
                  : contracts.isLoading == true
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: CupertinoActivityIndicator(
                              radius: 20,
                            ),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 32.0, left: 50),
                          child: Text(
                            "No Medical History!",
                            style: TextStyle(
                                fontSize:30 ,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
