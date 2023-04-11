import 'package:fluttertoast/fluttertoast.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class Connector {
  static late EthereumAddress address;
  // static late String key;
  static late EthPrivateKey key;
  // static String blockchainUrl =
  //     "https://rinkeby.infura.io/v3/e88563d8f10a486a888e8660c887eec4";

  static String blockchainUrl =
      'http://127.0.0.1:7545';


  static Client httpClient = Client();
  static Web3Client ethClient = Web3Client(blockchainUrl, httpClient);

  static Future<DeployedContract> getContractPatient() async {
    String abiFilePatient =
        await rootBundle.loadString("build/contracts/patient.json");
    String contractAddress = "0xbD91fDd8058158AE2648d8020Aac24E99B52a9c6";
    final contractPatient = DeployedContract(
        ContractAbi.fromJson(abiFilePatient, "Patient"),
        EthereumAddress.fromHex(contractAddress));

    return contractPatient;
  }

  static Future<DeployedContract> getContractDoctor() async {
    String abiFileDoctor =
        await rootBundle.loadString("build/contracts/doctor.json");
    String contractAddress = "0x28358d9Dd54A753051E3Fd30149FB59BfDCa8964";
    final contractDoctor = DeployedContract(
        ContractAbi.fromJson(abiFileDoctor, "Doctor"),
        EthereumAddress.fromHex(contractAddress));
    return contractDoctor;
  }

  static Future<bool> isDoctorExists(EthereumAddress address) async {
    final contract = await getContractDoctor();
    final result = await ethClient.call(
        contract: contract,
        function: contract.function("isDoctor"),
        params: [address]);
    return result[0];
  }

  static Future<bool> isPatientExists(EthereumAddress address) async {
    final contract = await getContractPatient();
    final result = await ethClient.call(
        contract: contract,
        function: contract.function("isPatient"),
        params: [address]);
    return result[0];
  }

  // static Future<String> getFee(EthereumAddress address) async {
  //   final contract = await getContractDoctor();
  //   final result = await ethClient.call(
  //       contract: contract,
  //       function: contract.function("getFee"),
  //       params: [address]);
  //   return result[0].toString();
  // }

  static Future<bool> isAuthorized(
      EthereumAddress doc, EthereumAddress pat) async {
    final contract = await getContractPatient();
    final result = await ethClient.call(
        contract: contract,
        function: contract.function("isAuthorized"),
        params: [doc, pat]);
    return result[0];
  }

  static Future<dynamic> getPresc(EthereumAddress address) async {
    final contract = await getContractPatient();
    final result = await ethClient.call(
        contract: contract,
        function: contract.function("viewPrescription"),
        params: [address]);
    return result[0];
  }

  static Future<bool> logInDoctor(String address, String privateKey) async {
    EthereumAddress addr = EthereumAddress.fromHex(address);
    bool result = await isDoctorExists(addr);
    if (result == true) return true;
    Credentials key = EthPrivateKey.fromHex(privateKey);

    //obtain our contract from abi in json file
    final contract = await getContractDoctor();

    // extract function from json file
    final function = contract.function("addDoctor");

    //send transaction using the our private key, function and contract
    await ethClient.sendTransaction(
      key,
      Transaction.callContract(
          contract: contract, function: function, parameters: [addr]),
      chainId: 1337,
    );
    //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
    await Future.delayed(const Duration(seconds: 40), () {});
    result = await isDoctorExists(addr);
    return result;
  }

  static Future<bool> logInPatient(String address, String privateKey) async {
    // print("here2");
    EthereumAddress addr = EthereumAddress.fromHex(address);
    bool result = await isPatientExists(addr);
    // print("here3");
    if (result == true) return true;
    Credentials key = EthPrivateKey.fromHex(privateKey);
    // print("here4");
    //obtain our contract from abi in json file
    final contract = await getContractPatient();

    // extract function from json file
    final function = contract.function("addPatient");

    //send transaction using the our private key, function and contract
    await ethClient.sendTransaction(
      key,
      Transaction.callContract(
          contract: contract, function: function, parameters: [addr]),
      chainId: 1337,
    );
    //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
    await Future.delayed(const Duration(seconds: 40), () {});
    result = await isPatientExists(addr);
    return result;
  }

  // static Future<String> updateDoctorFee(
  //     EthereumAddress address, String privateKey, String amount) async {
  //   Credentials key = EthPrivateKey.fromHex(privateKey);

  //   //obtain our contract from abi in json file
  //   final contract = await getContractDoctor();

  //   // extract function from json file
  //   final function = contract.function("updateFee");

  //   //send transaction using the our private key, function and contract
  //   // print("here2");
  //   await ethClient.sendTransaction(
  //       key,
  //       Transaction.callContract(
  //           contract: contract,
  //           function: function,
  //           parameters: [address, BigInt.parse(amount)]),
  //       chainId: 4);
  //   // print("here3");
  //   //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
  //   await Future.delayed(const Duration(seconds: 40), () {});
  //   // print("here4");
  //   String result = await getFee(address);
  //   return result;
  // }

  static Future<bool> addAuthorization(
      EthereumAddress doc, EthereumAddress pat, String privateKey) async {
    bool result = await isAuthorized(doc, pat);
    if (result) return true;
    // String fee = await getFee(doc);

    Credentials key = EthPrivateKey.fromHex(privateKey);

    //obtain our contract from abi in json file
    final contract = await getContractPatient();

    // extract function from json file
    final function = contract.function("addAuthorization");

    //send transaction using the our private key, function and contract
    // await ethClient.sendTransaction(
    //     key,
    //     Transaction.callContract(
    //         value: EtherAmount.fromUnitAndValue(EtherUnit.wei, fee),
    //         contract: contract,
    //         function: function,
    //         parameters: [doc, pat, BigInt.parse(fee)]),
    //     chainId: 4);
    //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
    await Future.delayed(const Duration(seconds: 40), () {});
    result = await isAuthorized(doc, pat);
    return result;
  }

  static Future<void> setPresc(EthereumAddress doc, EthereumAddress pat,
      String privateKey, String prescription) async {
    if (await isAuthorized(doc, pat)) {
      Credentials key = EthPrivateKey.fromHex(privateKey);

      //obtain our contract from abi in json file
      final contract = await getContractPatient();

      // extract function from json file
      final function = contract.function("setPrescription");

      //send transaction using the our private key, function and contract
      await ethClient.sendTransaction(
          key,
          Transaction.callContract(
              contract: contract,
              function: function,
              parameters: [prescription, pat, doc]),
          chainId: 1337);
    } else {
      Fluttertoast.showToast(msg: "You are not authorized");
    }
  }
}


// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:web3dart/web3dart.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart';

// class Connector {
//   static late EthereumAddress address;
//   // static late String key;
//   static late EthPrivateKey key;
//   // static String blockchainUrl =
//   //     "https://rinkeby.infura.io/v3/e88563d8f10a486a888e8660c887eec4";

//   static String blockchainUrl =
//       'http://127.0.0.1:7545';


//   static Client httpClient = Client();
//   static Web3Client ethClient = Web3Client(blockchainUrl, httpClient);

//   static Future<DeployedContract> getContractPatient() async {
//     String abiFilePatient =
//         await rootBundle.loadString("build/contracts/patient.json");
//     String contractAddress = "0xbD91fDd8058158AE2648d8020Aac24E99B52a9c6";
//     final contractPatient = DeployedContract(
//         ContractAbi.fromJson(abiFilePatient, "Patient"),
//         EthereumAddress.fromHex(contractAddress));

//     return contractPatient;
//   }

//   static Future<DeployedContract> getContractDoctor() async {
//     String abiFileDoctor =
//         await rootBundle.loadString("build/contracts/doctor.json");
//     String contractAddress = "0x28358d9Dd54A753051E3Fd30149FB59BfDCa8964";
//     final contractDoctor = DeployedContract(
//         ContractAbi.fromJson(abiFileDoctor, "Doctor"),
//         EthereumAddress.fromHex(contractAddress));
//     return contractDoctor;
//   }

//   static Future<bool> isDoctorExists(EthereumAddress address) async {
//     final contract = await getContractDoctor();
//     final result = await ethClient.call(
//         contract: contract,
//         function: contract.function("isDoctor"),
//         params: [address]);
//     return result[0];
//   }

//   static Future<bool> isPatientExists(EthereumAddress address) async {
//     final contract = await getContractPatient();
//     final result = await ethClient.call(
//         contract: contract,
//         function: contract.function("isPatient"),
//         params: [address]);
//     return result[0];
//   }

//   // static Future<String> getFee(EthereumAddress address) async {
//   //   final contract = await getContractDoctor();
//   //   final result = await ethClient.call(
//   //       contract: contract,
//   //       function: contract.function("getFee"),
//   //       params: [address]);
//   //   return result[0].toString();
//   // }

//   static Future<bool> isAuthorized(
//       EthereumAddress doc, EthereumAddress pat) async {
//     final contract = await getContractPatient();
//     final result = await ethClient.call(
//         contract: contract,
//         function: contract.function("isAuthorized"),
//         params: [doc, pat]);
//     return result[0];
//   }

//   static Future<dynamic> getPresc(EthereumAddress address) async {
//     final contract = await getContractPatient();
//     final result = await ethClient.call(
//         contract: contract,
//         function: contract.function("viewPrescription"),
//         params: [address]);
//     return result[0];
//   }

//   static Future<bool> logInDoctor(String address, String privateKey) async {
//     EthereumAddress addr = EthereumAddress.fromHex(address);
//     bool result = await isDoctorExists(addr);
//     if (result == true) return true;
//     Credentials key = EthPrivateKey.fromHex(privateKey);

//     //obtain our contract from abi in json file
//     final contract = await getContractDoctor();

//     // extract function from json file
//     final function = contract.function("addDoctor");

//     //send transaction using the our private key, function and contract
//     await ethClient.sendTransaction(
//       key,
//       Transaction.callContract(
//           contract: contract, function: function, parameters: [addr]),
//       chainId: 1337,
//     );
//     //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
//     await Future.delayed(const Duration(seconds: 40), () {});
//     result = await isDoctorExists(addr);
//     return result;
//   }

//   static Future<bool> logInPatient(String address, String privateKey) async {
//     // print("here2");
//     EthereumAddress addr = EthereumAddress.fromHex(address);
//     bool result = await isPatientExists(addr);
//     // print("here3");
//     if (result == true) return true;
//     Credentials key = EthPrivateKey.fromHex(privateKey);
//     // print("here4");
//     //obtain our contract from abi in json file
//     final contract = await getContractPatient();

//     // extract function from json file
//     final function = contract.function("addPatient");

//     //send transaction using the our private key, function and contract
//     await ethClient.sendTransaction(
//       key,
//       Transaction.callContract(
//           contract: contract, function: function, parameters: [addr]),
//       chainId: 1337,
//     );
//     //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
//     await Future.delayed(const Duration(seconds: 40), () {});
//     result = await isPatientExists(addr);
//     return result;
//   }

//   // static Future<String> updateDoctorFee(
//   //     EthereumAddress address, String privateKey, String amount) async {
//   //   Credentials key = EthPrivateKey.fromHex(privateKey);

//   //   //obtain our contract from abi in json file
//   //   final contract = await getContractDoctor();

//   //   // extract function from json file
//   //   final function = contract.function("updateFee");

//   //   //send transaction using the our private key, function and contract
//   //   // print("here2");
//   //   await ethClient.sendTransaction(
//   //       key,
//   //       Transaction.callContract(
//   //           contract: contract,
//   //           function: function,
//   //           parameters: [address, BigInt.parse(amount)]),
//   //       chainId: 4);
//   //   // print("here3");
//   //   //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
//   //   await Future.delayed(const Duration(seconds: 40), () {});
//   //   // print("here4");
//   //   String result = await getFee(address);
//   //   return result;
//   // }

//   static Future<bool> addAuthorization(
//       EthereumAddress doc, EthereumAddress pat, String privateKey) async {
//     bool result = await isAuthorized(doc, pat);
//     if (result) return true;
//     // String fee = await getFee(doc);

//     Credentials key = EthPrivateKey.fromHex(privateKey);

//     //obtain our contract from abi in json file
//     final contract = await getContractPatient();

//     // extract function from json file
//     final function = contract.function("addAuthorization");

//     //send transaction using the our private key, function and contract
//     // await ethClient.sendTransaction(
//     //     key,
//     //     Transaction.callContract(
//     //         value: EtherAmount.fromUnitAndValue(EtherUnit.wei, fee),
//     //         contract: contract,
//     //         function: function,
//     //         parameters: [doc, pat, BigInt.parse(fee)]),
//     //     chainId: 4);
//     //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
//     await Future.delayed(const Duration(seconds: 40), () {});
//     result = await isAuthorized(doc, pat);
//     return result;
//   }

//   static Future<void> setPresc(EthereumAddress doc, EthereumAddress pat,
//       String privateKey, String prescription) async {
//     if (await isAuthorized(doc, pat)) {
//       Credentials key = EthPrivateKey.fromHex(privateKey);

//       //obtain our contract from abi in json file
//       final contract = await getContractPatient();

//       // extract function from json file
//       final function = contract.function("setPrescription");

//       //send transaction using the our private key, function and contract
//       await ethClient.sendTransaction(
//           key,
//           Transaction.callContract(
//               contract: contract,
//               function: function,
//               parameters: [prescription, pat, doc]),
//           chainId: 1337);
//     } else {
//       Fluttertoast.showToast(msg: "You are not authorized");
//     }
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:web3dart/web3dart.dart';

// // class EthereumLoginPage extends StatefulWidget {
// //   @override
// //   _EthereumLoginPageState createState() => _EthereumLoginPageState();
// // }

// class Connector  {
//   late String ethereumAddress;
//   late String privateKey;
//   String loginStatus = '';
//   //   static late EthereumAddress address;
// //   // static late String key;
// //   static late EthPrivateKey key;

//   Future<void> loginWithEthereum() async {
//     // Connect to Ethereum network using Web3dart
//     final client = Web3Client('http://127.0.0.1:7545', Client());

//     // Validate Ethereum address
//     if (EthereumAddress.validateChecksum(ethereumAddress)) {
//       try {
//         // Convert private key to credentials
//         final credentials = await client.credentialsFromPrivateKey(privateKey);
        
//         // Use Ethereum address and private key for login
//         // TODO: Add your login logic here

//         setState(() {
//           loginStatus = 'Login successful!';
//         });
//       } catch (e) {
//         setState(() {
//           loginStatus = 'Login failed: $e';
//         });
//       }
//     } else {
//       setState(() {
//         loginStatus = 'Invalid Ethereum address';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Ethereum Login')),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 onChanged: (value) => ethereumAddress = value,
//                 decoration: InputDecoration(labelText: 'Ethereum Address'),
//               ),
//               TextField(
//                 onChanged: (value) => privateKey = value,
//                 decoration: InputDecoration(labelText: 'Private Key'),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: loginWithEthereum,
//                 child: Text('Login with Ethereum'),
//               ),
//               SizedBox(height: 16.0),
//               Text(loginStatus),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
