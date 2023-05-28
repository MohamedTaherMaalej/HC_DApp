import 'package:flutter/material.dart';
import 'package:hc_dapp/Pages/splash_screen_1.dart';
import 'package:hc_dapp/Pages/selection.dart';
import 'package:hc_dapp/Pages/doctor_login.dart';
import 'package:hc_dapp/Pages/patient_login.dart';
import 'package:hc_dapp/Pages/doctor_home_page.dart';
import 'package:hc_dapp/Pages/patient_home_page.dart';
// import 'package:hc_dapp/Pages/view_prescription.dart';
import 'package:hc_dapp/Pages/doctor_signup_page.dart';
import 'package:hc_dapp/Pages/patient_signup_page.dart';

class MyRoutes {
  static const String splashScreenPage = "/splashScreenPage";
  static const String selectionPage = "/selectionPage";
  static const String doctorLoginPage = "/doctorLogin";
  static const String patientLoginPage = "/patientLogin";

  static const String doctorHomePage = "/doctorHome";
  static const String patientHomePage = "/patientHome";

  static const String doctorSignupPage = "/doctorSignup";
  static const String patientSignupPage = "/patientSignup";

  static final routes = <String, WidgetBuilder>{
    splashScreenPage: (context) => const SplashScreenPage(),
    selectionPage: (context) => const SelectionPage(),
    doctorLoginPage: (context) => const DoctorLoginPage(),
    patientLoginPage: (context) => const PatientLoginPage(),
    doctorHomePage: (context) => const DoctorHomePage(),
    patientHomePage: (context) => const PatientHomePage(),
    doctorSignupPage: (context) => const DoctorSignupPage(),
    patientSignupPage: (context) => const PatientSignupPage(),
  };
}
