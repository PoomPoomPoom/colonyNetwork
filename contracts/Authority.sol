/*
  This file is part of The Colony Network.

  The Colony Network is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  The Colony Network is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with The Colony Network. If not, see <http://www.gnu.org/licenses/>.
*/

pragma solidity ^0.4.23;
pragma experimental "v0.5.0";

import "../lib/dappsys/roles.sol";


contract Authority is DSRoles {
  uint8 ownerRole = 0;
  uint8 adminRole = 1;
  uint8 recoveryRole = 2;

  constructor(address colony) public {
    ownerRoles(colony);
    ownerAndAdminRoles(colony);
    ownerAndRecoveryRoles(colony);
  }

  function ownerRoles(address colony) public {
    // functions for owner role
    bytes4 setTokenSig = bytes4(keccak256("setToken(address)"));
    bytes4 bootstrapColonySig = bytes4(keccak256("bootstrapColony(address[],int256[])"));
    bytes4 mintTokensSig = bytes4(keccak256("mintTokens(uint256)"));
    bytes4 addGlobalSkillSig = bytes4(keccak256("addGlobalSkill(uint256)"));
    bytes4 setOwnerRoleSig = bytes4(keccak256("setOwnerRole(address)"));
    bytes4 removeAdminRoleSig = bytes4(keccak256("removeAdminRole(address)"));
    bytes4 setRecoveryRoleSig = bytes4(keccak256("setRecoveryRole(address)"));
    bytes4 removeRecoveryRoleSig = bytes4(keccak256("removeRecoveryRole(address)"));
    bytes4 upgradeSig = bytes4(keccak256("upgrade(uint256)"));

    // Set token
    setRoleCapability(ownerRole, colony, setTokenSig, true);
    // Bootstrap colony
    setRoleCapability(ownerRole, colony, bootstrapColonySig, true);
    // Mint tokens
    setRoleCapability(ownerRole, colony, mintTokensSig, true);
    // Add global skill
    setRoleCapability(ownerRole, colony, addGlobalSkillSig, true);
    // Transfer ownership
    setRoleCapability(ownerRole, colony, setOwnerRoleSig, true);
    // Remove admin role
    setRoleCapability(ownerRole, colony, removeAdminRoleSig, true);
    // Set recovery role
    setRoleCapability(ownerRole, colony, setRecoveryRoleSig, true);
    // Remove recovery role
    setRoleCapability(ownerRole, colony, removeRecoveryRoleSig, true);
    // Upgrade colony
    setRoleCapability(ownerRole, colony, upgradeSig, true);
  }

  function ownerAndAdminRoles(address colony) public {
    // functions for admin + owner role
    bytes4 moveFundsBetweenPotsSig = bytes4(keccak256("moveFundsBetweenPots(uint256,uint256,uint256,address)"));
    bytes4 addDomainSig = bytes4(keccak256("addDomain(uint256)"));
    bytes4 makeTaskSig = bytes4(keccak256("makeTask(bytes32,uint256)"));
    bytes4 startNextRewardPayoutSig = bytes4(keccak256("startNextRewardPayout(address)"));
    bytes4 cancelTaskSig = bytes4(keccak256("cancelTask(uint256)"));
    bytes4 setAdminRoleSig = bytes4(keccak256("setAdminRole(address)"));

    // Allocate funds
    setRoleCapability(adminRole, colony, moveFundsBetweenPotsSig, true);
    setRoleCapability(ownerRole, colony, moveFundsBetweenPotsSig, true);
    // Add domain
    setRoleCapability(adminRole, colony, addDomainSig, true);
    setRoleCapability(ownerRole, colony, addDomainSig, true);
    // Add task
    setRoleCapability(adminRole, colony, makeTaskSig, true);
    setRoleCapability(ownerRole, colony, makeTaskSig, true);
    // Start next reward payout
    setRoleCapability(adminRole, colony, startNextRewardPayoutSig, true);
    setRoleCapability(ownerRole, colony, startNextRewardPayoutSig, true);
    // Cancel task
    setRoleCapability(adminRole, colony, cancelTaskSig, true);
    setRoleCapability(ownerRole, colony, cancelTaskSig, true);
    // Set admin
    setRoleCapability(adminRole, colony, setAdminRoleSig, true);
    setRoleCapability(ownerRole, colony, setAdminRoleSig, true);
  }

  function ownerAndRecoveryRoles(address colony) public {
    // functions for owner + recovery role;
    bytes4 enterRecoveryModeSig = bytes4(keccak256("enterRecoveryMode()"));
    bytes4 approveExitRecoverySig = bytes4(keccak256("approveExitRecovery()"));
    bytes4 setStorageSlotRecoverySig = bytes4(keccak256("setStorageSlotRecovery(uint256,bytes32)"));

    // Recovery mode
    setRoleCapability(ownerRole, colony, enterRecoveryModeSig, true);
    setRoleCapability(recoveryRole, colony, enterRecoveryModeSig, true);

    setRoleCapability(ownerRole, colony, setStorageSlotRecoverySig, true);
    setRoleCapability(recoveryRole, colony, setStorageSlotRecoverySig, true);

    setRoleCapability(ownerRole, colony, approveExitRecoverySig, true);
    setRoleCapability(recoveryRole, colony, approveExitRecoverySig, true);
  }
}
