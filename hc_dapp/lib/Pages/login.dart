// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';



// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController address = TextEditingController();
//   TextEditingController privateKey = TextEditingController();
//   //TextEditingController role = TextEditingController();
//   //final _formKey = GlobalKey<FormState>();

//   _showPicker() {
//     showModalBottomSheet(
//         context: context,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(5.0))),
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Wrap(
//               children: <Widget>[
//                 const Padding(
//                   padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
//                   child: Text(
//                     "Roles",
//                     style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 ListTile(
//                     leading: const Icon(
//                       CupertinoIcons.person_alt_circle,
//                       color: Colors.black,
//                     ),
//                     title: const Text(
//                       'Patient',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     onTap: () {
//                       role.text = "Patient";
//                       setState(() {});
//                       Navigator.pop(context);
//                     }),
//                 ListTile(
//                     leading: const Icon(
//                       FontAwesomeIcons.userDoctor,
//                       color: Colors.black,
//                     ),
//                     title: const Text(
//                       'Doctor',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     onTap: () {
//                       role.text = "Doctor";
//                       setState(() {});
//                       Navigator.pop(context);
//                     })
//               ],
//             ),
//           );
//         });
//   }

// }