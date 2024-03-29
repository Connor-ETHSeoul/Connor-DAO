// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ConnerDao {
    enum Vote {
        Agree,
        Disagree,
        Abstain
    }

    struct VotingStatus {
        int agree;
        uint disagree;
        uint abstain;
        bool isListed;
    }

    struct Policy {
        uint policyId;
        string title;
        string description;
        string policy;
    }

    uint private _policyId;

    mapping(uint => Policy) public policyDetail;
    mapping(uint => VotingStatus) public voteStatus;

    uint[] public listedPolicy;

    event PolicyListed(string policy);

    function vote(uint policyId, Vote voting) public {
        VotingStatus storage currentVoting = voteStatus[policyId];
        require(currentVoting.isListed == false, "Policy already listed");
        if (voting == Vote.Agree) {
            currentVoting.agree += 1;
        } else if (voting == Vote.Disagree) {
            currentVoting.disagree += 1;
        } else {
            currentVoting.abstain += 1;
        }

        if (currentVoting.agree >= 50) {
            currentVoting.isListed = true;
            listedPolicy.push(policyId);
            emit PolicyListed(policyDetail[policyId].policy);
        }
    }

    function makePolicy(
        string memory title,
        string memory description,
        string memory policy
    ) public {
        Policy memory newPolicy = Policy(_policyId, title, description, policy);
        policyDetail[_policyId++] = newPolicy;
    }

    function getListedPolicy() public view returns (uint[] memory) {
        return listedPolicy;
    }

    function restart(uint policyId) public {
        VotingStatus storage currentVoting = voteStatus[policyId];
        currentVoting.agree = 49;
        currentVoting.disagree = 30;
        currentVoting.abstain = 20;
        currentVoting.isListed = false;
    }
}
