import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:developer' as dev;


class Contracts extends ChangeNotifier {
    final String _rpcURL =
      Platform.isAndroid ? 'http://10.0.2.2:7545' : 'http://127.0.0.1:7545';
  final String _wsURL =
      Platform.isAndroid ? 'http://10.0.2.2:7545' : 'ws://127.0.0.1:7545';
  final String _privateKey ="8bd96f0a258df9f7806c984d477d163ed87fa682963c273728631502ad2ab082";
  late Web3Client _client;
  late EthPrivateKey _creds;
  //DoctorContract
  late ContractAbi _abiCodeDoctor;
  late EthereumAddress _contractAddressDoctor;
  late DeployedContract _contractDoctor;
  late ContractFunction _existDoctor;
  late ContractFunction _addDoctor;
  late ContractFunction _displayDoctor;
  //PatientContract
  late ContractAbi _abiCodePatient;
  late EthereumAddress _contractAddressPatient;
   late DeployedContract _contractPatient;
  late ContractFunction _existPatient;
  late ContractFunction _addPatient;
  late ContractFunction _permission;
  late ContractFunction _deletePermission;
  late ContractFunction _checkPermission;
  late ContractFunction _setPrescription;
  late ContractFunction _displayPrescriptions;
  late ContractFunction _displayPatient;
  late bool isLoading=true;
  var prescriptions=[];
  var doctorData="";
  var patientData="";
  Contracts() {
    init();
  }
  Future<void> init() async{
    _client = Web3Client(_rpcURL, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsURL).cast<String>();
    },);
    await getABIDoctor();
    await getABIPatient();
    await getCredentials();
    await getContracts();
    await displayPrescriptions();
    await displayPatient();
    await displayDoctor();
  }
  Future<void> getABIDoctor() async{
    String abiFile = await rootBundle.loadString('build/contracts/doctor.json');
    var jsonABI=jsonDecode(abiFile);
    _abiCodeDoctor= ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'doctor');
    _contractAddressDoctor =
        EthereumAddress.fromHex(jsonABI["networks"]["5777"]["address"]);
  }
  Future<void> getABIPatient() async{
    String abiFile = await rootBundle.loadString('build/contracts/patient.json');
    var jsonABI=jsonDecode(abiFile);
    _abiCodePatient= ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'patient');
    _contractAddressPatient =
        EthereumAddress.fromHex(jsonABI["networks"]["5777"]["address"]);
  }
  Future<void> getCredentials() async {
    _creds=EthPrivateKey.fromHex(_privateKey);
    dev.log(_creds.address.toString());
  }
  Future<void> getContracts() async {
    //doctor contracts
    _contractDoctor= DeployedContract(_abiCodeDoctor, _contractAddressDoctor);
    _addDoctor=_contractDoctor.function('addDoctor');
    _existDoctor=_contractDoctor.function('exist');
    _displayDoctor=_contractDoctor.function('displayDoctor');
    //patient contracts
    _contractPatient= DeployedContract(_abiCodePatient, _contractAddressPatient);
    _existPatient=_contractPatient.function('exist');
    _addPatient=_contractPatient.function('addPatient');
    _permission=_contractPatient.function('permission');
    _deletePermission=_contractPatient.function('deletePermission');
    _checkPermission=_contractPatient.function('checkPermission');
    _setPrescription=_contractPatient.function('setPrescription');
    _displayPrescriptions=_contractPatient.function('displayPrescription');
    _displayPatient=_contractPatient.function('displayPatient');

  }
  Future<void> addDoctor(String firstName , String lastName) async {
    notifyListeners();
    dev.log(firstName+" "+lastName);
    var id= await _client.getChainId();
    print(id);
    await _client.sendTransaction(
      _creds,
      Transaction.callContract(
        contract: _contractDoctor,
        function: _addDoctor,
        parameters: [firstName,lastName],
      ),
      chainId: 1337,
    );
  }
  Future<bool> existDoctor() async {
      var a = await _client.call(
          sender: _creds.address,
          contract: _contractDoctor,
          function: _existDoctor,
          params: []);
          notifyListeners();
          return a[0];
  }
  Future<void> displayDoctor() async {
      var a = await _client.call(
          sender: _creds.address,
          contract: _contractDoctor,
          function: _displayDoctor,
          params: []);
          notifyListeners();
          doctorData=a[0].toString()+" "+a[1].toString();
  }
  Future<void> addPatient(String firstName , String lastName) async {
    notifyListeners();
    dev.log(firstName+" "+lastName);
    await _client.sendTransaction(
      _creds,
      Transaction.callContract(
        contract: _contractPatient,
        function: _addPatient,
        parameters: [firstName,lastName],
      ),
      chainId: 1337,
    );
  }
  
  Future<void> deletePermission() async {
    notifyListeners();
    await _client.sendTransaction(
      _creds,
      Transaction.callContract(
        contract: _contractPatient,
        function: _deletePermission,
        parameters: [],
      ),
      chainId: 1337,
    );
  }
  Future<void> permission(EthereumAddress doctor) async {
    notifyListeners();
    await _client.sendTransaction(
      _creds,
      Transaction.callContract(
        contract: _contractPatient,
        function: _permission,
        parameters: [doctor],
      ),
      chainId: 1337,
    );
  }      
  Future<bool> checkPermission(EthereumAddress patient) async {
    notifyListeners();
    var a = await _client.call(
          sender: _creds.address,
          contract: _contractPatient,
          function: _checkPermission,
          params: [patient]);
          notifyListeners();
          return a[0];
  }
  Future<bool> existPatient() async {
      var a = await _client.call(
          sender: _creds.address,
          contract: _contractPatient,
          function: _existPatient,
          params: []);
          notifyListeners();
          return a[0];
  }
  Future<void> setPrescription(EthereumAddress patient,String diagnosis,String medications,String advices,String date) async {
    notifyListeners();
    await _client.sendTransaction(
      _creds,
      Transaction.callContract(
        contract: _contractPatient,
        function: _setPrescription,
        parameters: [patient,diagnosis,medications,advices,date],
      ),
      chainId: 1337,
    );
  }
  Future<void> displayPrescriptions() async {
      var a = await _client.call(
          sender: _creds.address,
          contract: _contractPatient,
          function: _displayPrescriptions,
          params: []);
          isLoading=false;
          prescriptions=a[0];
          notifyListeners();
  }
    Future<void> displayPatient() async {
      var a = await _client.call(
          sender: _creds.address,
          contract: _contractPatient,
          function: _displayPatient,
          params: []);
          notifyListeners();
          patientData=a[0].toString()+" "+a[1].toString();
  }
}