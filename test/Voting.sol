pragma solidity 0.8.7;
import "./RegistrationSimple.sol";
    contract VotingContract {
        
        uint256 EndElectionTime;
        bytes32 PollWinner;
        bytes32 Question;
        bytes32[] CandidateList;
        address payable EventAdmin;
        uint NumOfCand;
        bool completed;
        uint totalNumVotes;
        address payable system = payable(0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C);
        address RegistrationContractAddress;
        mapping(address => bool) public verify;
        mapping(bytes32 => uint) private votes;
        mapping(uint => bytes32) public options;

        modifier onlyOwner {
            require(msg.sender == EventAdmin);
            _;
        }
        function getNumVotes() public view returns(uint) {
            return totalNumVotes;
        }
        function getNumCandidates() public view returns(uint) {
            return NumOfCand;
        }
        
        function getQuestion() public view returns(bytes32) {
            return Question;
        }
        function isEligble(address _address) public view returns(bool) {
            Register reg = Register(RegistrationContractAddress);
            return reg.isEligble(_address);
        }

        constructor (bytes32 theQuestion, bytes32[] memory candidateNames, address _RegistrationContractAddress, uint256 _endElectionTime) {
            RegistrationContractAddress = _RegistrationContractAddress;
            Question = theQuestion;
            EventAdmin = payable(msg.sender);
            NumOfCand = candidateNames.length;
            CandidateList = candidateNames;
            EndElectionTime = _endElectionTime;
            completed = false;
            for (uint i = 0; i < candidateNames.length; i++) {
                options[i] = candidateNames[i];
                votes[candidateNames[i]] = 0;
            }
        }

        function getCandidate(uint candidateIndex) public view returns(bytes32) {
            if (candidateIndex > NumOfCand - 1)
                return (0);
            else return (options[candidateIndex]);
        }

        function CanVote() onlyOwner private view returns(bool) {
            if (verify[msg.sender] == true || completed == true || !isEligble(msg.sender))
                return false;
            else return true;
        }

        function getTotalVotesFor(bytes32 candidate) public view returns(uint) {
            // this function should only be available after vote is finished
            if (!completed)
                revert("election is not finished!");
            else
                return (votes[candidate]);
        }

        function VoteFor(bytes32 candidate) public {
            if ((verify[msg.sender] == true) || (completed == true) || !isEligble(msg.sender))
                revert();
            else {
                votes[candidate] += 1;
                totalNumVotes += 1;
                verify[msg.sender] = true;
            }
        }

        function getPot() onlyOwner public view returns(uint) {
            return address(this).balance;
        }


        function FinishAndDistributeTheRevenues() public returns(uint,uint) {
            if  (block.timestamp < EndElectionTime)
                revert("election is not finished!");
            else {
                EventAdmin.transfer(address(this).balance / 3);
                system.transfer(address(this).balance);
                completed = true;
                return (EventAdmin.balance, system.balance);
            }
        }


    }