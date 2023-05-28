// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
contract Doctor {
    struct doctorData{
        string firstName;
        string lastName;
    }
   mapping(address =>doctorData) doctors;
   address[] add;
   mapping(address =>bool) doctorExist;
    function addDoctor(string memory firstName , string memory lastName) public {
        doctorData memory doctor;
        doctor.firstName=firstName;
        doctor.lastName=lastName;
        doctors[msg.sender]=doctor;
        doctorExist[msg.sender]=true;
    }
    function exist() public view returns (bool){
        return (doctorExist[msg.sender]);
    }
    function displayDoctor() public view returns (string memory, string memory){
        return(doctors[msg.sender].firstName,doctors[msg.sender].lastName);
    }
}