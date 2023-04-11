// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

contract Doctor {
    mapping(address => bool) isExists;

    function addDoctor(address doc) public {
        require(!isExists[doc], "Doctor already exists");
        isExists[doc] = true;
    }


    function isDoctor(address doc) public view returns (bool) {
        return isExists[doc];
    }
}