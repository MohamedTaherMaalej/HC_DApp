var doctor = artifacts.require("./contracts/doctor.sol");
var patient = artifacts.require("./contracts/patient.sol");

module.exports = function(deployer) {
  deployer.deploy(doctor);
  deployer.deploy(patient);
};