// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EmergencyAudit {
    struct AuditEntry {
        string incidentId;
        string action;
        string hashValue;
        uint256 timestamp;
    }

    mapping(uint256 => AuditEntry) public entries;
    uint256 public entryCount;

    function logEntry(string memory incidentId, string memory action, string memory hashValue) public {
        entryCount++;
        entries[entryCount] = AuditEntry(incidentId, action, hashValue, block.timestamp);
    }
}
