// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
contract Patient {
    struct patientData{
        string firstName;
        string lastName;
    }
    struct prescription{
        address doctor;
        string diagnosis;
        string medications;
        string advices;
        string date;
    }
   mapping(address=>patientData) patients;
   mapping(address=>address) permissions;
   mapping(address=>prescription[]) prescriptions;
   mapping(address=>bool) patientExist;
   function addPatient(string memory firstName, string memory lastName) public {
    patientData memory patient;
    patient.firstName=firstName;
    patient.lastName=lastName;
    patients[msg.sender]=patient;
    patientExist[msg.sender]=true;
   }
   function permission(address doctor) public {
        permissions[msg.sender]=doctor;
   }
   function deletePermission() public {
        delete permissions[msg.sender];
   }
   function checkPermission(address patient) public view returns(bool){
    return(permissions[patient]==msg.sender);
   }
   function setPrescription(address patient,string memory diagnosis,string memory medications,string memory advices,string memory date) public {
        require(checkPermission(patient),"Permission denied");
        prescription memory pres;
        pres.date=date;
        pres.diagnosis=diagnosis;
        pres.medications=medications;
        pres.advices=advices;
        pres.doctor=msg.sender;
        prescriptions[patient].push(pres);
   }
    function exist() public view returns (bool){
        return (patientExist[msg.sender]);
    }
    function displayPrescription() public view returns(prescription[] memory){
        return(prescriptions[msg.sender]);
    }
    function displayPatient() public view returns (string memory, string memory){
        return(patients[msg.sender].firstName,patients[msg.sender].lastName);
    }
}
