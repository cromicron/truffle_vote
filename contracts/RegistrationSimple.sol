pragma solidity 0.8.7;

contract Register {

    mapping(address => bool) public EligbleVotersAddresses;
    mapping(uint32 => bool) public RegisteredStudentIds;

    constructor(uint32[] memory studentIDs) {
        for (uint32 i = 0; i < studentIDs.length; i++){
            RegisteredStudentIds[studentIDs[i]] = true;
        }
    }

    function addStudentID(uint32 studentID) public {
        if (RegisteredStudentIds[studentID] == true)
            revert();        
        else
            RegisteredStudentIds[studentID] = true;
    }

    function isEligble(address _address) public view returns(bool) {
        if (EligbleVotersAddresses[_address] == true)
            return true;
        else return false;
    }
    function verify(uint32 studentID) public {
        if (RegisteredStudentIds[studentID] == true) {
            EligbleVotersAddresses[msg.sender] = true;
        }
    }

}